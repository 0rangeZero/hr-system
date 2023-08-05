<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
        <el-row>
            <el-col :span="5">
                <el-form-item label="申请记录">
                <el-input style="width: 95%" v-model="searchObj.keywords" placeholder="请假理由/工号/姓名"></el-input>
                </el-form-item>
            </el-col>
            <el-col :span="9">
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
                <el-button style="margin-left: 10px" type="primary" icon="el-icon-search" size="mini" @click="fetchApplyData()">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
            </el-col>
        </el-row>
    </el-form>
  </div>


    <!-- 请假审批表格 -->
    <br />
    <span style="font-weight: bold;">请假审批</span>
    <el-table
        v-loading="listLoading"
        :data="listApproval"
        stripe
        border
        style="width: 100%;margin-top: 10px;">
        <el-table-column
        label="序号"
        width="70"
        align="center">
        <template slot-scope="scope">
            {{ (pageApproval - 1) * limitApproval + scope.$index + 1 }}
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
            type="success"
            icon="el-icon-circle-check" 
            size="mini" 
            @click="pass(scope.row.leaveId, scope.row.userId)" 
            :disabled="$hasBP('btn.leave.pass')  === false" 
            title="通过"/>
            <el-button 
            type="danger" 
            icon="el-icon-circle-close"
            size="mini" 
            @click="reject(scope.row.leaveId)" 
            :disabled="$hasBP('btn.leave.reject')  === false" 
            title="驳回"/>
        </template>
        </el-table-column>
    </el-table>
    <!-- 分页组件 -->
    <el-pagination
        :current-page="pageApproval"
        :total="totalApproval"
        :page-size="limitApproval"
        style="padding: 30px 0; text-align: center;"
        layout="total, prev, pager, next, jumper"
        @current-change="fetchApprovalData"
    />

    <!-- 请假申请记录表格 -->
    <br />
    <span style="font-weight: bold;">申请记录</span>
    <el-table
        v-loading="listLoading"
        :data="listApply"
        stripe
        border
        style="width: 100%;margin-top: 10px;">
        <el-table-column
        label="序号"
        width="70"
        align="center">
        <template slot-scope="scope">
            {{ (pageApply - 1) * limitApply + scope.$index + 1 }}
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
        <el-table-column label="操作" width="50">
            <template slot-scope="scope">
                <el-button
                @click="deleteRow(scope.row.leaveId, scope.row.userId)"
                type="text"
                size="small"
                style="color: red;text-decoration: underline;">
                撤销
                </el-button>
            </template>
        </el-table-column>
    </el-table>
    <!-- 分页组件 -->
    <el-pagination
        :current-page="pageApply"
        :total="totalApply"
        :page-size="limitApply"
        style="padding: 30px 0; text-align: center;"
        layout="total, prev, pager, next, jumper"
        @current-change="fetchApplyData"
    />

  </div>
</template>
<script>
import api from '@/api/system/leave'
const defaultFormApproval = {
    leaveId: '',
    leaveDays: '',
    leaveTime: '',
    leaveReason: '',
    passed: '',
    userId: '',
    workId: '',
    name: '',
    sex: ''
}
const defaultFormApply = {
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
        listApproval: [], // 审批列表
        totalApproval: 0, // 总记录数
        pageApproval: 1, // 页码
        limitApproval: 3, // 每页记录数
        leaveApproval: defaultFormApproval, // 请假属性封装

        listApply: [], // 申请列表
        totalApply: 0, // 总记录数
        pageApply: 1, // 页码
        limitApply: 5, // 每页记录数
        leaveApply: defaultFormApply, // 请假属性封装
        
        listLoading:true, // 数据是否正在加载
        searchObj: {}, // 封装查询条件
        createTimes: '',
    }
  },
  //页面渲染之前获取数据
  created() {
    this.fetchData()
  },
  // 定义方法
  methods: {
    fetchData() {
        this.fetchApplyData()
        this.fetchApprovalData()
    },
    fetchApprovalData(pageNum = 1) {
        this.pageApproval = pageNum
        // 请假审批调用api
        api.getList(this.pageApproval, this.limitApproval, this.searchObj, 2).then(response => {
            this.listLoading = false
            this.listApproval = response.data.records
            this.totalApproval = response.data.total
        })
    },
    fetchApplyData(pageNum = 1) {
        this.pageApply = pageNum
        if(this.createTimes && this.createTimes.length == 2) {
            this.searchObj.createTimeBegin = this.createTimes[0]
            this.searchObj.createTimeEnd = this.createTimes[1]
        }
        // 申请记录调用api
        api.getList(this.pageApply, this.limitApply, this.searchObj, 1).then(response => {
            this.listLoading = false
            this.listApply = response.data.records
            this.totalApply = response.data.total
        })
    },
    // 重置表单
    resetData() {
        this.createTimes = ''
        this.searchObj = {}
        this.fetchData()
    },
    // 申请通过
    pass(leaveId, userId) {
        this.$confirm('是否通过该申请?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            api.pass(leaveId, userId).then(response => {
                this.$message.success('申请已通过' || response.message)
                this.fetchData()
            })
        }).catch(() => {
            this.$message.info("申请通过已取消")
        })
    },
    // 申请驳回
    reject(id) {
        this.$confirm('是否驳回该申请?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            api.reject(id).then(response => {
                this.$message.success('申请已驳回' || response.message)
                this.fetchData()
            })
        }).catch(() => {
            this.$message.info("申请驳回已取消")
        })
    },
    // 撤销申请
    deleteRow(leaveId, userId) {
        this.$confirm('此操作将永久删除该记录，是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            api.revocation(leaveId, userId).then(response => {
                this.$message.success('撤销成功' || response.message)
                this.fetchData()
            })
        }).catch(() => {
            this.$message.info("撤销已取消")
        })
    }
  }
}
</script>