<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
        <el-row>
            <el-col :span="9">
                <el-form-item label="发放时间">
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
            <el-col :span="5">
                <el-button style="margin-left: 10px" type="primary" icon="el-icon-search" size="mini" @click="fetchData()">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
            </el-col>
        </el-row>
        <!-- 工具条 -->
        <div class="tools-div">
            <el-button :loading="downloadLoading" size="mini" type="success" icon="el-icon-folder" @click="exportData">
                导出Excel
            </el-button>
        </div>
    </el-form>
  </div>

    <!-- 表格 -->
    <br />
    <el-table
        v-loading="listLoading"
        :data="list"
        stripe
        border
        style="width: 100%;margin-top: 10px;">
        <el-table-column
            label="序号"
            width="70"
            align="center"
            fixed>
            <template slot-scope="scope">
                {{ (page - 1) * limit + scope.$index + 1 }}
            </template>
        </el-table-column>
        <el-table-column prop="createTime" label="发放时间" align="center" width="200" fixed />
        <el-table-column prop="workId" label="工号" align="center" />
        <el-table-column prop="name" label="姓名" align="center" />
        <el-table-column prop="sex" label="性别" align="center" />
        <el-table-column prop="deptName" label="所属部门" align="center" />
        <el-table-column prop="postName" label="职位" align="center" />
        <el-table-column label="工资详细" align="center">
            <el-table-column prop="basicSalary" label="基本工资" align="center" />
            <el-table-column prop="meritPay" label="绩效工资" align="center" />
            <el-table-column prop="allowance" label="补助补贴" align="center" />
            <el-table-column prop="bonus" label="奖金" align="center" />
            <el-table-column prop="finsurances" label="五险一金" align="center" />
            <el-table-column prop="sum" label="合计" align="center">
                <template slot-scope="scope">
                    {{scope.row.basicSalary+scope.row.meritPay+scope.row.allowance+scope.row.bonus+scope.row.finsurances}}
                </template>
            </el-table-column>
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

  </div>
</template>
<script>
import api from '@/api/system/salary'
import deptApi from '@/api/system/dept'
import userApi from '@/api/system/user'
const defaultForm = {
    salaryName: '',
    salaryId: '',
    userId: '',
}
export default {
  // 定义数据模型
  data() {
    return {
        list: [], // 申请列表
        total: 0, // 总记录数
        page: 1, // 页码
        limit: 5, // 每页记录数
        salary: defaultForm, // 薪酬属性封装
        
        downloadLoading: false,
        listLoading: true, // 数据是否正在加载
        searchObj: {}, // 封装查询条件
        createTimes: '',

        deptList: [], // 部门列表

        token: '',
        BASE_API: process.env.VUE_APP_BASE_API
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
            // 获取工资发放记录
            userApi.getMyPayOff(this.page, this.limit, this.searchObj).then(response => {
                this.list = response.data.records
                this.total = response.data.total
                this.listLoading = false
            })
            // 获取部门列表
            deptApi.getAll().then(response => {
                this.deptList = response.data
            })
        },
        // 重置表单
        resetData() {
            this.createTimes = ''
            this.searchObj = {}
            this.fetchData()
        },
        exportData() {
            window.location.href = this.BASE_API + '/system/salary/export'
        }
    }
}
</script>