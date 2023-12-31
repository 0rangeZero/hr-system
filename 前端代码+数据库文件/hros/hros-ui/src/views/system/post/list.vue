<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
        <el-row :gutter="20">
            <el-col :span="6">
                <el-form-item label="职位名称">
                    <el-input style="width: 230px" v-model="searchObj.postName" placeholder="职位名称"></el-input>
                </el-form-item>
            </el-col>
            <el-col :span="5">
                <el-form-item label="隶属部门" prop="deptName">
                    <el-select v-model="searchObj.deptName" style="width: 150px" placeholder="请选择隶属部门">
                        <el-option v-for="item in deptList" :key="item.deptId" :label="item.deptName" :value="item.deptName">
                        </el-option>
                    </el-select>
                </el-form-item>
            </el-col>
            <el-col :span="8">
                <el-button style="margin-left: 10px" type="primary" icon="el-icon-search" size="mini" @click="fetchData()">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
            </el-col>
        </el-row>
      <!-- 工具条 -->
      <div class="tools-div">
        <el-button type="success" icon="el-icon-plus" size="mini" @click="add" :disabled="$hasBP('btn.post.add')  === false">添 加</el-button>
        <el-button type="danger" icon="el-icon-close" size="mini" @click="batchRemove" :disabled="$hasBP('btn.post.batchRemove')  === false">批量删除</el-button>
      </div>
    </el-form>
  </div>

  <!-- 表格 -->
  <el-table
    v-loading="listLoading"
    :data="list"
    stripe
    border
    style="width: 100%;margin-top: 10px;"
    @selection-change="handleSelectionChange">

    <el-table-column type="selection"/>

    <el-table-column
      label="序号"
      width="70"
      align="center">
      <template slot-scope="scope">
        {{ (page - 1) * limit + scope.$index + 1 }}
      </template>
    </el-table-column>

    <el-table-column prop="postName" label="职位名称" />
    <el-table-column prop="postCode" label="职位编码" />
    <el-table-column prop="deptName" label="隶属部门" />
    <el-table-column prop="createTime" label="创建时间" width="360"/>
    <el-table-column label="状态" width="80" align="center" v-if="$hasBP('ns.post.status')">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status === 1"
            @change="switchStatus(scope.row)">
          </el-switch>
        </template>
    </el-table-column>
    <el-table-column label="状态" width="80" align="center" v-if="!$hasBP('ns.post.status')">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status === 1"
            @change="switchStatus(scope.row)"
            disabled>
          </el-switch>
        </template>
    </el-table-column>
    <el-table-column label="操作" width="200" align="center">
      <template slot-scope="scope">
        <el-button type="primary" icon="el-icon-edit" size="mini" @click="edit(scope.row.postId)" :disabled="$hasBP('btn.post.update')  === false" title="修改"/>
        <el-button type="danger" icon="el-icon-delete" size="mini" @click="removeDataById(scope.row.postId)" :disabled="$hasBP('btn.post.remove')  === false" title="删除"/>
      </template>
    </el-table-column>
  </el-table>

  <!-- 分页组件 -->
  <el-pagination
    :current-page="page"
    :total="total"
    :page-size="limit"
    style="padding: 30px 0; text-align: center;"
    layout="total, prev, pager, next, jumper"
    @current-change="fetchData"
  />

  <el-dialog title="添加/修改" :visible.sync="dialogVisible" width="40%" >
    <el-form ref="dataForm" :model="post" :rules="rules" label-width="150px" size="small" style="padding-right: 40px;">
        <el-form-item label="职位名称" prop="postName">
            <el-input v-model="post.postName"/>
        </el-form-item>
        <el-form-item label="职位编码" prop="postCode">
            <el-input v-model="post.postCode"/>
        </el-form-item>
        <el-form-item label="隶属部门" prop="deptName">
            <el-select v-model="post.deptName" placeholder="请选择隶属部门">
                <el-option v-for="item in validDeptList" :key="item.deptId" :label="item.deptName" :value="item.deptName">
                </el-option>
            </el-select>
        </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button @click="cancel" size="small" icon="el-icon-close">取 消</el-button>
      <el-button type="primary" icon="el-icon-check" @click="saveOrUpdate('dataForm')" size="small">确 定</el-button>
    </span>
  </el-dialog>

  </div>
</template>
<script>
import api from '@/api/system/post'
import deptApi from '@/api/system/dept'
const defaultForm = {
    postId: '',
    postName: '',
    postCode: '',
    deptId: '',
    deptName: ''
}
export default {
  // 定义数据模型
  data() {
    return {
      rules: {
        postName: [
          { required: true, message: '职位名称不能为空', trigger: 'blur' }
        ],
        postCode: [
          { required: true, message: '职位编码不能为空', trigger: 'blur' },
          { pattern: /^[a-zA-Z]+$/, message: '职位编码必须为纯英文' }
        ],
        deptName: [
            { required: true, message: '请选择隶属的部门', trigger: 'blur' }
        ]
      },
      listLoading:true, // 数据是否正在加载
      list: [], // 职位列表
      total: 0, // 总记录数
      page: 1, // 页码
      limit: 5, // 每页记录数
      searchObj: {}, // 封装查询条件

      dialogVisible: false, //弹窗显示
      post: defaultForm, // 职位属性封装
      saveBtnDisabled: false, // 保存按钮是否可用

      multipleSelection: [], // 批量删除选中的记录列表

      deptList: [], // 部门列表
      validDeptList: [], // 可用的部门列表
      value: '' 
    }
  },
  //页面渲染之前获取数据
  created() {
    this.fetchData()
  },
  // 定义方法
  methods: {
    fetchData(pageNum = 1) {
      this.page = pageNum
      // 调用api
      api.getPageList(this.page, this.limit, this.searchObj).then(response => {
        this.listLoading = false
        this.list = response.data.records
        this.total = response.data.total
      })
      deptApi.getAll().then(response => {
        this.deptList = response.data
      })
      deptApi.getValid().then(response => {
        this.validDeptList = response.data
      })
    },
    // 重置表单
    resetData() {
      this.searchObj = {}
      this.fetchData()
    },
    // 删除职位
    removeDataById(id) {
      this.$confirm('此操作将永久删除此记录，是否继续？', '提示', {
        cancelButtonText: '取消',
        confirmButtonText: '确定',
        type: 'warning'
      }).then(() => {
        api.removeById(id).then(response => {
          this.$message.success('删除成功' || response.message)
        })
        api.getPageList(this.page, this.limit, this.searchObj).then(response => {
          this.list = response.data.records
          if (this.list.length === 0) this.fetchData(this.page - 1)
          else this.fetchData(this.page)
        })
      }).catch(() => {
         this.$message.info('取消删除')
      })
    },
    // 添加功能弹窗
    add() {
      this.dialogVisible = true
      this.post = {}
    },
    // 同一个窗口实现添加修改功能
    saveOrUpdate(formName) {
      if (!this.post.postId) { // 传入职位属性中不包含职位id，执行添加操作
        this.save(formName)
      } else { // 否则执行修改操作
        this.update(formName)
      }
    },
    // 添加操作
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
            // console.log(this.post)
            api.save(this.post).then(response => {
                this.$message.success('操作成功' || response.message)
                this.dialogVisible = false
                this.fetchData(this.page)
          })
        }
      })
    },
    // 编辑弹窗，同时获取当前行信息
    edit(id) {
      this.dialogVisible = true
      api.getById(id).then(response => {
        this.post.postId = response.data.postId
        this.post.postName = response.data.postName
        this.post.postCode = response.data.postCode
        this.post.deptId = response.data.deptId
        deptApi.getById(this.post.deptId).then(res => {
            this.post.deptName = res.data.deptName
        })
      })
    },
    // 修改操作
    update(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.update(this.post).then(response => {
            this.$message.success('操作成功' || response.message)
            this.dialogVisible = false
            this.fetchData(this.page)
          })
        }
      })
    },
    // 当多选选项发生变化的时候调用
    handleSelectionChange(selection) {
      this.multipleSelection = selection
    },
    // 批量删除
    batchRemove() {
      if (this.multipleSelection.length === 0) {
        this.$message.warning('请选择要删除的记录！')
        return
      }
      this.$confirm('此操作将永久删除这些记录, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        // 遍历selection，将id取出放入id列表
        var idList = []
        this.multipleSelection.forEach(item => {
          idList.push(item.postId)
        })
        api.batchRemove(idList).then(response => {
          this.$message.success('删除成功' || response.message)
          this.fetchData(this.page)
        })
      })
    },
    //切换用户状态
    switchStatus(row) {
        row.status = row.status === 1 ? 0 : 1
        api.updateStatus(row.postId, row.status).then(response => {
            if (response.code) {
                this.$message.success('操作成功' || response.message)
                this.fetchData()
            }
        })
    },
    // 取消添加/修改
    cancel() {
      this.dialogVisible = false
      location.reload()
    }
  }
}
</script>