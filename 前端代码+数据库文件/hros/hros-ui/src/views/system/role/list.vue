<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
      <el-row>
        <el-col :span="24">
          <el-form-item label="角色名称">
            <el-input style="width: 300px" v-model="searchObj.roleName" placeholder="角色名称"></el-input>
            <el-button style="margin-left: 10px" type="primary" icon="el-icon-search" size="mini" @click="fetchData()">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
          </el-form-item>
        </el-col>
      </el-row>
      <!-- 工具条 -->
      <div class="tools-div">
        <el-button type="success" icon="el-icon-plus" size="mini" @click="add" :disabled="$hasBP('btn.role.add')  === false">添 加</el-button>
        <el-button type="danger" icon="el-icon-close" size="mini" @click="batchRemove" :disabled="$hasBP('btn.role.batchRemove')  === false">批量删除</el-button>
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

    <el-table-column prop="roleName" label="角色名称" />
    <el-table-column prop="roleCode" label="角色编码" />
    <el-table-column prop="createTime" label="创建时间" width="360"/>
    <el-table-column label="操作" width="200" align="center">
      <template slot-scope="scope">
        <el-button type="primary" icon="el-icon-edit" size="mini" @click="edit(scope.row.roleId)" :disabled="$hasBP('btn.role.update')  === false" title="修改"/>
        <el-button type="danger" icon="el-icon-delete" size="mini" @click="removeDataById(scope.row.roleId)" :disabled="$hasBP('btn.role.remove')  === false" title="删除"/>
        <el-button type="warning" icon="el-icon-baseball" size="mini" @click="showAssignAuth(scope.row)" :disabled="$hasBP('btn.role.assignAuth')  === false" title="分配权限"/>
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
    <el-form ref="dataForm" :model="role" :rules="rules" label-width="150px" size="small" style="padding-right: 40px;">
      <el-form-item label="角色名称" prop="roleName">
        <el-input v-model="role.roleName"/>
      </el-form-item>
      <el-form-item label="角色编码" prop="roleCode">
        <el-input v-model="role.roleCode"/>
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
import api from '@/api/system/role'
const defaultForm = {
  roleId: '',
  roleName: '',
  roleCode: ''
}
export default {
  // 定义数据模型
  data() {
    return {
      rules: {
        roleName: [
          { required: true, message: '角色名称不能为空', trigger: 'blur' }
        ],
        roleCode: [
          { required: true, message: '角色编码不能为空', trigger: 'blur' },
          { pattern: /^[a-zA-Z]+$/, message: '角色编码必须为纯英文' }
        ],
      },
      listLoading:true, // 数据是否正在加载
      list: [], // 角色列表
      total: 0, // 总记录数
      page: 1, // 页码
      limit: 5, // 每页记录数
      searchObj: {}, // 封装查询条件

      dialogVisible: false, //弹窗显示
      role: defaultForm, // 角色属性封装
      saveBtnDisabled: false, // 保存按钮是够可用

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
    // 删除角色
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
      this.role = {}
    },
    // 同一个窗口实现添加修改功能
    saveOrUpdate(formName) {
      if (!this.role.roleId) { // 传入角色属性中不包含角色id，执行添加操作
        this.save(formName)
      } else { // 否则执行修改操作
        this.update(formName)
      }
    },
    // 添加操作
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.save(this.role).then(response => {
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
        this.role.roleId = response.data.roleId
        this.role.roleName = response.data.roleName
        this.role.roleCode = response.data.roleCode
      })
    },
    // 修改操作
    update(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.update(this.role).then(response => {
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
          idList.push(item.roleId)
        })
        api.batchRemove(idList).then(response => {
          this.$message.success('删除成功' || response.message)
          this.fetchData(this.page)
        })
      })
    },
    // 跳转到选择页面
    showAssignAuth(row) {
      this.$router.push('/system/assignAuth?id='+row.roleId+'&roleName='+row.roleName);
    },
    cancel() {
      this.dialogVisible = false
      location.reload()
    }
  }
}
</script>