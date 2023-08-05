<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
        <el-row>
            <el-col :span="5">
                <el-form-item label="关 键 字">
                <el-input style="width: 95%" v-model="searchObj.keyword" placeholder="姓名/工号"></el-input>
                </el-form-item>
            </el-col>
            <el-col :span="8">
                <el-form-item label="签到时间">
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
        <el-button type="danger" icon="el-icon-close" size="mini" @click="batchRemove" :disabled="$hasBP('btn.clock.batchRemove')  === false">
          批量删除
        </el-button>
        <el-button :loading="downloadLoading" size="mini" type="success" icon="el-icon-folder" @click="exportData">
          导出Excel
        </el-button>
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
        <template slot-scope="scope" prop="id">
            {{ (page - 1) * limit + scope.$index + 1 }}
        </template>
        </el-table-column>

        <el-table-column prop="clockTime" label="打卡日期" sortable />
        <el-table-column prop="workId" label="工号" />
        <el-table-column prop="name" label="姓名" />
        <el-table-column prop="sex" label="性别" />
        
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
import api from '@/api/system/clock'
const defaultForm = {
  userId: '',
  name: '',
  sex: '',
  workId: '',
  clockTime: ''
}
export default {
  // 定义数据模型
  data() {
    return {
        listLoading:true, // 数据是否正在加载
        list: [], // 打卡列表
        total: 0, // 总记录数
        page: 1, // 页码
        limit: 7, // 每页记录数
        searchObj: {}, // 封装查询条件
        clock: defaultForm, // 打卡信息属性封装
        multipleSelection: [], // 批量删除选中的记录列表
        idList: [], // 批量删除id列表
        createTimes: [],
        downloadLoading: false,
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
          idList.push(item.clockId)
        })
        api.batchRemove(idList).then(response => {
          this.$message.success('删除成功' || response.message)
          if (this.list.length === 0) this.fetchData(this.page - 1)
          else this.fetchData(this.page)
        })
      })
    },
    // 当多选选项发生变化的时候调用
    handleSelectionChange(selection) {
      this.multipleSelection = selection
    },
    exportData() {
      window.location.href = this.BASE_API + '/system/clock/export'
    }
  }
}
</script>