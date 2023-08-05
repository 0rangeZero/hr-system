<template>
<div class="app-container">

  <!--查询表单-->
  <div class="search-div">
    <el-form label-width="70px" size="small">
      <el-row>
        <el-col :span="5">
            <el-form-item label="部  门" prop="deptName">
                <el-select v-model="searchObj.deptId" style="width: 180px" placeholder="请选择部门">
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
      <!-- 工具条 -->
      <div class="tools-div">
        <el-button 
          type="primary" 
          icon="el-icon-plus" 
          size="mini" @click="add" 
          :disabled="$hasBP('btn.salary.add')  === false">添加账套</el-button>
        <el-button 
          type="danger" 
          icon="el-icon-close" 
          size="mini" 
          @click="batchRemove" 
          :disabled="$hasBP('btn.salary.batchRemove')  === false">批量删除</el-button>
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

        <el-table-column prop="salaryName" label="账套名称" width="200" />
        <el-table-column prop="basicSalary" label="基本工资" />
        <el-table-column prop="meritPay" label="绩效工资" />
        <el-table-column prop="allowance" label="补助补贴" />
        <el-table-column prop="bonus" label="奖金" />
        <el-table-column prop="finsurances" label="五险一金" />
        <el-table-column prop="sum" label="合计">
            <template slot-scope="scope">
                {{scope.row.basicSalary+scope.row.meritPay+scope.row.allowance+scope.row.bonus+scope.row.finsurances}}
            </template>
        </el-table-column>
        <el-table-column label="操作" width="200" align="center">
        <template slot-scope="scope">
            <el-button type="primary" 
                icon="el-icon-edit" 
                size="mini" 
                @click="edit(scope.row.salaryId)" :disabled="$hasBP('btn.salary.update')  === false" 
                title="修改"/>
            <el-button 
                type="danger" 
                icon="el-icon-delete" 
                size="mini" 
                @click="removeDataById(scope.row.salaryId)" 
                :disabled="$hasBP('btn.salary.remove')  === false" 
                title="删除"/>
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

  <el-dialog title="添加/修改" :visible.sync="dialogVisible" width="32%" >
    <el-form ref="dataForm" :model="salary" :rules="rules" label-width="150px" size="small" style="padding-right: 40px;">
        <el-form-item label="部门" prop="deptId">
            <el-select v-model="salary.deptId" placeholder="请选择该账套所属的部门">
                <el-option v-for="item in deptList" :key="item.deptId" :label="item.deptName" :value="item.deptId">
                </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="账套名称" prop="salaryName">
            <el-input style="width: 190px" v-model="salary.salaryName"/>
        </el-form-item>
        <el-form-item label="基本工资" prop="basicSalary">
            <el-input style="width: 80px" v-model="salary.basicSalary"/> 元
        </el-form-item>
        <el-form-item label="绩效工资" prop="meritPay">
            <el-input style="width: 80px" v-model="salary.meritPay"/> 元
        </el-form-item>
        <el-form-item label="补助补贴" prop="allowance">
            <el-input style="width: 80px" v-model="salary.allowance"/> 元
        </el-form-item>
        <el-form-item label="奖金" prop="bonus">
            <el-input style="width: 80px" v-model="salary.bonus"/> 元
        </el-form-item>
        <el-form-item label="五险一金" prop="finsurances">
            <el-input style="width: 80px" v-model="salary.finsurances"/> 元
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
import api from '@/api/system/salary'
import deptApi from '@/api/system/dept'
const defaultForm = {
    salaryId: '',
    salaryName: '',
    basicSalary: '',
    meritPay: '',
    allowance: '',
    bonus: '',
    finsurances: '',
    deptId: '',
}
export default {
  // 定义数据模型
  data() {
    return {
        rules: {
          deptId: [
            { required: true, message: '请选择该账套所属的部门', trigger: 'blur' },
          ],
          salaryName: [
            { required: true, message: '请输入账套名称', trigger: 'blur' },
          ],
          basicSalary: [
            { required: true, message: '基本工资不能为空', trigger: 'blur' },
            { pattern: /^[0-9]*$/, message: '基本工资只能为数字' }
          ],
          meritPay: [
            { required: true, message: '绩效工资不能为空', trigger: 'blur' },
            { pattern: /^[0-9]*$/, message: '绩效工资只能为数字' }
          ],
          allowance: [
            { required: true, message: '补助补贴不能为空', trigger: 'blur' },
            { pattern: /^[0-9]*$/, message: '补助补贴只能为数字' }
          ],
          bonus: [
            { required: true, message: '奖金不能为空', trigger: 'blur' },
            { pattern: /^[0-9]*$/, message: '奖金只能为数字' }
          ],
          finsurances: [
            { required: true, message: '五险一金不能为空', trigger: 'blur' },
            { pattern: /^[0-9]*$/, message: '五险一金只能为数字' }
          ]
        },
        listLoading:true, // 数据是否正在加载
        list: [], // 账套列表
        total: 0, // 总记录数
        page: 1, // 页码
        limit: 5, // 每页记录数
        searchObj: {}, // 封装查询条件

        dialogVisible: false, //弹窗显示
        multipleSelection: [], // 批量删除选中的记录列表

        salary: defaultForm, // 角色属性封装
        deptList: [], // 部门列表
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
      // 获取分页数据
      api.getPageList(this.page, this.limit, this.searchObj).then(response => {
        this.listLoading = false
        this.list = response.data.records
        this.total = response.data.total
      })
      // 获取部门列表
      deptApi.getAll().then(response => {
        this.deptList = response.data
      })
    },
    // 重置表单
    resetData() {
      this.searchObj = {}
      this.fetchData()
    },
    // 删除账套
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
      this.salary = {}
    },
    // 同一个窗口实现添加修改功能
    saveOrUpdate(formName) {
      if (!this.salary.salaryId) { // 传入角色属性中不包含角色id，执行添加操作
        this.save(formName)
      } else { // 否则执行修改操作
        this.update(formName)
      }
    },
    // 添加操作
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.save(this.salary).then(response => {
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
        this.salary = response.data
      })
    },
    // 修改操作
    update(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          api.update(this.salary).then(response => {
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
          idList.push(item.salaryId)
        })
        api.batchRemove(idList).then(response => {
          this.$message.success('删除成功' || response.message)
          this.fetchData(this.page)
        })
      })
    },
    // 删除账套
    removeDataById(id) {
        this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => {
            return api.removeById(id)
        }).then((response) => {
            api.getPageList(this.page, this.limit, this.searchObj).then(response => {
                this.list = response.data.records
                if (this.list.length === 0) this.fetchData(this.page - 1)
                else this.fetchData(this.page)
            })
            this.$message.success('删除成功' || response.message)
        }).catch(() => {
            this.$message.info('取消删除')
        })
    },
    cancel() {
      this.dialogVisible = false
      location.reload()
    }
  }
}
</script>