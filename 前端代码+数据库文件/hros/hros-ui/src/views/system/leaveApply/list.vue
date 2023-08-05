<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
        <el-row>
            <el-col :span="5">
                <el-form-item label="关 键 字">
                <el-input style="width: 95%" v-model="searchObj.keywords" placeholder="请假理由..."></el-input>
                </el-form-item>
            </el-col>
            <el-col :span="8">
                <el-form-item label="申请时间">
                <el-date-picker
                    v-model="createTimes"
                    type="datetimerange"
                    range-separator="至"
                    start-placeholder="开始时间"
                    end-placeholder="结束时间"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    style="margin-right: 10px;width: 100%;"
                />
                </el-form-item>
            </el-col> 
            <el-col :span="8">
                <el-button style="margin-left: 10px" type="primary" icon="el-icon-search" size="mini" @click="fetchData()">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
            </el-col>
        </el-row>
        <!-- 工具条 -->
        <div class="tools-div">
            <el-button type="success" icon="el-icon-plus" size="mini" @click="add" :disabled="$hasBP('btn.leave.add')  === false">申 请</el-button>
        </div>
    </el-form>
  </div>

  <!-- 表格 -->
  <el-table
    v-loading="listLoading"
    :data="list"
    stripe
    border
    style="width: 100%;margin-top: 10px;">

    <el-table-column
      label="序号"
      width="70"
      align="center">
      <template slot-scope="scope">
        {{ (page - 1) * limit + scope.$index + 1 }}
      </template>
    </el-table-column>

    <el-table-column prop="leaveTime" label="请假时间" align="center" width="120" />
    <el-table-column prop="leaveDays" label="请假天数" align="center" width="80" />
    <el-table-column prop="leaveReason" label="请假理由" align="center" :show-overflow-tooltip="true" />
    <el-table-column prop="workId" label="工号" align="center" width="100" />
    <el-table-column prop="name" label="姓名" align="center" width="80" />
    <el-table-column prop="sex" label="性别" align="center" width="80" />
    <el-table-column label="状态" width="80" align="center">
      <template slot-scope="scope">
        <el-tag type="danger" v-if="scope.row.passed === 0">驳回</el-tag>
        <el-tag type="success" v-if="scope.row.passed === 1">通过</el-tag>
        <el-tag type="warning" v-if="scope.row.passed === 2">待审批</el-tag>
      </template>
    </el-table-column>
    <el-table-column label="操作" width="200" align="center">
      <template slot-scope="scope">
        <el-button
          type="primary"
          icon="el-icon-edit" 
          size="mini" 
          @click="edit(scope.row.leaveId)" 
          :disabled="$hasBP('btn.leave.update')  === false || scope.row.passed !== 2" 
          title="修改"/>
        <el-button 
          type="danger" 
          icon="el-icon-delete" 
          size="mini" 
          @click="removeDataById(scope.row.leaveId)" 
          :disabled="$hasBP('btn.leave.remove')  === false || scope.row.passed !== 2" 
          title="撤回"/>
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

  <el-dialog title="申请/修改" :visible.sync="dialogVisible" width="40%" >
    <el-form ref="dataForm" :model="leave" :rules="rules" label-width="150px" size="small" style="padding-right: 40px;">
      <el-form-item label="请假天数" prop="leaveDays">
        <el-input v-model="leave.leaveDays" style="width: 55px" /> 天
      </el-form-item>
      <el-form-item label="请假时间" prop="leaveTime">
          <el-date-picker type="date" placeholder="选择日期" v-model="leave.leaveTime" style="width: 40%;"></el-date-picker>
      </el-form-item>
      <el-form-item label="请假理由" prop="leaveReason">
        <el-input
          type="textarea" 
          v-model="leave.leaveReason"
          :rows="10"
          maxlength="200"
          show-word-limit></el-input>
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
import api from '@/api/system/leave'
const defaultForm = {
    leaveId: '',
    leaveDays: '',
    leaveTime: '',
    leaveReason: '',
    passed: '',
    workId: '',
    name: '',
    sex: ''
}
export default {
  // 定义数据模型
  data() {
    return {
      rules: {
        leaveDays: [
          { required: true, message: '请假天数不能为空', trigger: 'blur' }
        ],
        leaveTime: [
          { required: true, message: '请假时间不能为空', trigger: 'blur' }
        ],
        leaveReason: [
          { required: true, message: '请假理由不能为空', trigger: 'blur' }
        ]
      },
      listLoading:true, // 数据是否正在加载
      list: [], // 申请列表
      total: 0, // 总记录数
      page: 1, // 页码
      limit: 5, // 每页记录数
      searchObj: {}, // 封装查询条件

      dialogVisible: false, //弹窗显示
      leave: defaultForm, // 请假属性封装
      createTimes: '',
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
      if(this.createTimes && this.createTimes.length ==2) {
        this.searchObj.createTimeBegin = this.createTimes[0]
        this.searchObj.createTimeEnd = this.createTimes[1]
      }
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
      this.createTimes = ''
      this.fetchData()
    },
    // 删除请假申请
    removeDataById(id) {
      this.$confirm('此操作将永久撤销此记录，是否继续？', '提示', {
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
      this.leave = {}
    },
    // 同一个窗口实现添加修改功能
    saveOrUpdate(formName) {
      if (!this.leave.leaveId) { // 传入请假属性中不包含请假id，执行添加操作
        this.save(formName)
      } else { // 否则执行修改操作
        this.update(formName)
      }
    },
    // 添加操作
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.save(this.leave).then(response => {
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
        this.leave = response.data
      })
    },
    // 修改操作
    update(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.update(this.leave).then(response => {
            this.$message.success('操作成功' || response.message)
            this.dialogVisible = false
            this.fetchData(this.page)
          })
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