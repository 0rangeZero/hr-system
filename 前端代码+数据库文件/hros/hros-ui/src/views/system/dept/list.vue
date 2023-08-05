<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
      <el-row>
        <el-col :span="24">
          <el-form-item label="部门名称">
            <el-input style="width: 300px" v-model="searchObj.deptName" placeholder="部门名称"></el-input>
            <el-button style="margin-left: 10px" type="primary" icon="el-icon-search" size="mini" @click="fetchData()">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
          </el-form-item>
        </el-col>
      </el-row>
      <!-- 工具条 -->
      <div class="tools-div">
        <el-button type="success" icon="el-icon-plus" size="mini" @click="add" :disabled="$hasBP('btn.dept.add')  === false">添 加</el-button>
        <el-button type="danger" icon="el-icon-close" size="mini" @click="batchRemove" :disabled="$hasBP('btn.dept.batchRemove')  === false">批量删除</el-button>
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

    <el-table-column prop="deptName" label="部门名称" />
    <el-table-column prop="deptCode" label="部门编码" />
    <el-table-column prop="createTime" label="创建时间" width="360"/>
    <el-table-column label="状态" width="80" align="center" v-if="$hasBP('ns.dept.status')">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status === 1"
            @change="switchStatus(scope.row)">
          </el-switch>
        </template>
    </el-table-column>
    <el-table-column label="状态" width="80" align="center" v-if="!$hasBP('ns.dept.status')">
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
        <el-button type="primary" icon="el-icon-edit" size="mini" @click="edit(scope.row.deptId)" :disabled="$hasBP('btn.dept.update')  === false" title="修改"/>
        <el-button type="danger" icon="el-icon-delete" size="mini" @click="removeDataById(scope.row.deptId)" :disabled="$hasBP('btn.dept.remove')  === false" title="删除"/>
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
    <el-form ref="dataForm" :model="dept" :rules="rules" label-width="150px" size="small" style="padding-right: 40px;">
      <el-form-item label="部门名称" prop="deptName">
        <el-input v-model="dept.deptName"/>
      </el-form-item>
      <el-form-item label="部门编码" prop="deptCode">
        <el-input v-model="dept.deptCode"/>
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
import api from '@/api/system/dept'
const defaultForm = {
  deptId: '',
  deptName: '',
  deptCode: ''
}
export default {
  // 定义数据模型
  data() {
    return {
      rules: {
        deptName: [
          { required: true, message: '部门名称不能为空', trigger: 'blur' }
        ],
        deptCode: [
          { required: true, message: '部门编码不能为空', trigger: 'blur' },
          { pattern: /^[a-zA-Z]+$/, message: '部门编码必须为纯英文' }
        ],
      },
      listLoading:true, // 数据是否正在加载
      list: [], // 部门列表
      total: 0, // 总记录数
      page: 1, // 页码
      limit: 5, // 每页记录数
      searchObj: {}, // 封装查询条件

      dialogVisible: false, //弹窗显示
      dept: defaultForm, // 部门属性封装
      saveBtnDisabled: false, // 保存按钮是否可用

      multipleSelection: [] // 批量删除选中的记录列表
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
    },
    // 重置表单
    resetData() {
      this.searchObj = {}
      this.fetchData()
    },
    // 删除部门
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
      this.dept = {}
    },
    // 同一个窗口实现添加修改功能
    saveOrUpdate(formName) {
      if (!this.dept.deptId) { // 传入部门属性中不包含部门id，执行添加操作
        this.save(formName)
      } else { // 否则执行修改操作
        this.update(formName)
      }
    },
    // 添加操作
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.save(this.dept).then(response => {
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
        this.dept.deptId = response.data.deptId
        this.dept.deptName = response.data.deptName
        this.dept.deptCode = response.data.deptCode
      })
    },
    // 修改操作
    update(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.update(this.dept).then(response => {
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
          idList.push(item.deptId)
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
        api.updateStatus(row.deptId, row.status).then(response => {
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