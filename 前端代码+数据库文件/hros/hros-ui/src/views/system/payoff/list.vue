<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
        <el-row>
            <el-col :span="5">
                <el-form-item label="关 键 字">
                <el-input style="width: 100%" v-model="searchObj.keyword" placeholder="工号/姓名"></el-input>
                </el-form-item>
            </el-col>
            <el-col :span="5">
                <el-form-item label="部 门" prop="deptName">
                    <el-select v-model="searchObj.deptId" style="width: 150px;width: 95%;" placeholder="请选择员工隶属部门">
                        <el-option v-for="item in deptList" :key="item.deptId" :label="item.deptName" :value="item.deptId">
                        </el-option>
                    </el-select>
                </el-form-item>
            </el-col>
            <el-col :span="5">
                <el-button style="margin-left: 10px" type="primary" icon="el-icon-search" size="mini" @click="fetchData()">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
            </el-col>
        </el-row>
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
        align="center">
        <template slot-scope="scope">
            {{ (page - 1) * limit + scope.$index + 1 }}
        </template>
        </el-table-column>
        <el-table-column prop="workId" label="工号" align="center" />
        <el-table-column prop="name" label="姓名" align="center" />
        <el-table-column prop="sex" label="性别" align="center" />
        <el-table-column prop="deptName" label="所属部门" align="center" />
        <el-table-column prop="postName" label="职位" align="center" />
        <el-table-column prop="salaryName" label="工资账套" width="200" align="center">
            <template slot-scope="scope">
                <el-tag type="info" v-if="scope.row.salaryName === null">请选择账套信息</el-tag>
                <el-tag v-if="scope.row.salaryName !== null">{{scope.row.salaryName}}</el-tag>
            </template>
        </el-table-column>
        <el-table-column label="工资状态" align="center">
            <template slot-scope="scope">
                <el-tag type="warning" v-if="payList.indexOf(scope.row.userId) === -1">未发放</el-tag>
                <el-tag type="success" v-if="payList.indexOf(scope.row.userId) !== -1">已发放</el-tag>
            </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="230">
            <template slot-scope="scope">
                <el-popover
                    placement="top"
                    width="240"
                    trigger="manual"
                    :ref="`popoverCode${scope.row.userId}`">
                    <el-select v-model="salary.salaryName" style="width: 150px;width: 95%;" placeholder="请选择账套信息">
                        <el-option v-for="item in salaryList" :key="item.salaryId" :label="item.salaryName" :value="item.salaryName">
                        </el-option>
                    </el-select>
                    <p></p>
                    <div style="text-align: right; margin: 0">
                        <el-button size="mini" type="text" @click="cancel(scope.row)">取消</el-button>
                        <el-button type="primary" size="mini" @click="update(scope.row)">确定</el-button>
                    </div>
                    <el-button 
                        type="success" 
                        size="small" 
                        slot="reference" 
                        @click="showList(scope.row)"
                        :disabled="$hasBP('btn.payoff.update')  === false"
                        round>工资账套设置</el-button>
                </el-popover>
                &nbsp;
                <el-button
                    @click="pay(scope.row.userId, scope.row.salaryId)"
                    size="small"
                    type="primary" 
                    :disabled="$hasBP('btn.payoff.pay')  === false"
                    round>
                    工资发放
                </el-button>
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
        
        listLoading: true, // 数据是否正在加载
        searchObj: {}, // 封装查询条件
        createTimes: '',

        deptList: [], // 部门列表
        salaryList: [], // 账套信息列表
        payList: [], // 工资已发放列表
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
            // 获取员工信息
            userApi.getPageList(this.page, this.limit, this.searchObj).then(response => {
                this.list = response.data.records
                this.total = response.data.total
                this.listLoading = false
                this.hasPaid(this.list)
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
        // 弹出框弹出
        showList(data) {
            // 根据部门名称获取对应的账套信息
            this.salaryList = []
            api.getByDeptName(data.deptName).then(response => {
                this.salaryList = response.data
            })
            this.$refs[`popoverCode${data.userId}`].doShow()
        },
        // 账套修改
        update(data) {
            userApi.updateSalary(data.userId, this.salary.salaryName).then(response => {
                this.$message.success('修改成功' || response.message)
            })
            this.$refs[`popoverCode${data.userId}`].doClose()
            location.reload()
        },
        // 取消修改
        cancel(data) {
            this.$refs[`popoverCode${data.userId}`].doClose()
            location.reload()
        },
        // 工资发放
        pay(userId, salaryId) {
            this.$confirm('此操作将永久删除此记录，是否继续？', '提示', {
                cancelButtonText: '取消',
                confirmButtonText: '确定',
                type: 'warning'
            }).then(() => {
                if (salaryId !== null && salaryId !== '') {
                    if (this.payList.indexOf(userId) === -1) {
                        this.salary.userId = userId
                        this.salary.salaryId = salaryId
                        api.pay(this.salary).then(response => {
                            this.$message.success('工资发放成功' || response.message)
                        })
                        this.fetchData()
                    } else {
                        this.$message.warning('该员工当月工资已发放' || response.message)
                    }
                } else {
                    this.$message.warning('请选择账套信息' || response.message)
                }
            }).catch(() => {
                this.$message.info('工资发放已取消')
            })
        },
        // 查看工资是否发放
        hasPaid(list) {
            var idList = []
            list.forEach(item => {
                idList.push(item.userId)
            })
            api.getPayTime(idList).then(response => {
                this.payList = response.data
                console.log(this.payList)
            })
        },
    }
}
</script>