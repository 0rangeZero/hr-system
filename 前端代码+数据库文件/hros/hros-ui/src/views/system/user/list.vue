<template>
  <div class="app-container">

    <div class="search-div">
      <el-form label-width="70px" size="small">
        <el-row>
          <el-col :span="5">
            <el-form-item label="关 键 字">
              <el-input style="width: 95%" v-model="searchObj.keyword" placeholder="用户名/姓名/工号"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="9">
            <el-form-item label="入职时间">
              <el-date-picker
                v-model="createTimes"
                type="datetimerange"
                range-separator="至"
                start-placeholder="开始时间"
                end-placeholder="结束时间"
                value-format="yyyy-MM-dd HH:mm:ss"
                style="margin-right: 10px;width: 380px;"
              />
            </el-form-item>
          </el-col>
          <el-col :span="5">
            <el-form-item label="隶属部门" prop="deptName">
                <el-select v-model="searchObj.deptId" style="width: 150px;width: 95%;" placeholder="请选择隶属部门">
                    <el-option v-for="item in deptList" :key="item.deptId" :label="item.deptName" :value="item.deptId">
                    </el-option>
                </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="5">
            <el-form-item label="职位" prop="postName">
              <el-select v-model="searchObj.postId" placeholder="请选择所任职位">
                  <el-option v-for="item in searchPostList" :key="item.postId" :label="item.postName" :value="item.postId">
                  </el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row style="display:flex">
          <el-button type="primary" icon="el-icon-search" size="mini" @click="fetchData()">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetData">重置</el-button>
        </el-row>
      </el-form>
    </div>

    <!-- 工具条 -->
    <div class="tools-div">
      <el-button type="success" icon="el-icon-plus" size="mini" @click="add" :disabled="$hasBP('btn.user.add')  === false">添 加</el-button>
    </div>

	<!-- 列表 -->
    <el-table
      v-loading="listLoading"
      :data="list"
      stripe
      border
      style="width: 100%; margin-top: 10px;">

      <el-table-column
        fixed
        label="序号"
        width="70"
        align="center">
        <template slot-scope="scope">
          {{ (page - 1) * limit + scope.$index + 1 }}
        </template>
      </el-table-column>
      <el-table-column prop="workId" align="center" label="工号" width="100px"/>
      <el-table-column prop="userName" align="center" label="用户名"/>
      <el-table-column prop="name" align="center" label="姓名"/>
      <el-table-column prop="sex" align="center" label="性别" width="70px"/>
      <el-table-column prop="birthday" align="center" label="生日" width="120px"/>
      <el-table-column prop="address" align="center" label="家庭住址" width="300px"/>
      <el-table-column prop="phone" align="center" label="电话号码" width="120px"/>
      <el-table-column prop="email" align="center" label="电子邮箱" width="180px"/>
      <el-table-column prop="identification" align="center" label="身份证号" width="180px"/>
      <el-table-column prop="entryDate" align="center" label="入职日期" width="120px"/>
      <el-table-column prop="createTime" align="center" label="创建时间" width="180px"/>
      <el-table-column prop="deptName" align="center" label="部门" width="120px"/>
      <el-table-column prop="postName" align="center" label="职位" width="120px"/>

      <el-table-column fixed="right" label="状态" width="80" align="center" v-if="$hasBP('ns.user.status')">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status === 1"
            @change="switchStatus(scope.row)">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="状态" width="80" align="center" v-if="!$hasBP('ns.user.status')">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status === 1"
            @change="switchStatus(scope.row)"
            disabled>
          </el-switch>
        </template>
      </el-table-column>

      <el-table-column fixed="right" width="250px" label="操作" align="center">
        <template slot-scope="scope">
          <el-button type="primary" icon="el-icon-edit" size="mini" @click="edit(scope.row.userId)" :disabled="$hasBP('btn.user.update')  === false" title="修改"/>
          <el-button type="danger" icon="el-icon-delete" size="mini" @click="removeDataById(scope.row.userId)" :disabled="$hasBP('btn.user.remove')  === false" title="删除" />
          <el-button type="warning" icon="el-icon-baseball" size="mini" @click="showAssignRole(scope.row)" :disabled="$hasBP('btn.user.assignAuth')  === false" title="分配角色"/>
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

    <el-dialog title="添加/修改" :visible.sync="dialogVisible" width="50%" top="50px">
      <el-form ref="dataForm" :model="sysUser" :rules="rules" label-width="100px" size="small" style="padding-right: 40px;">
        <el-row>
          <el-col :span="12">
            <el-form-item label="姓名" prop="name">
                <el-input style="width: 190px" v-model="sysUser.name"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="性别" prop="sex">
                <el-select v-model="sysUser.sex" placeholder="性别">
                  <el-option label="男" value="男"></el-option>
                  <el-option label="女" value="女"></el-option>
                </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="部门" prop="deptName">
              <el-select v-model="sysUser.deptName" @change="selectPost" placeholder="请选择隶属部门">
                  <el-option v-for="item in validDeptList" :key="item.deptId" :label="item.deptName" :value="item.deptName">
                  </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="职位" prop="postName">
              <el-select v-model="sysUser.postName" placeholder="请选择所任职位">
                  <el-option v-for="item in postList" :key="item.postId" :label="item.postName" :value="item.postName">
                  </el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="工号" prop="workId">
              <span slot="label">
                <el-tooltip placement="top">
                  <div slot="content">
                    工号默认格式为“入职年份”+“部门编号”+“用户编号” <br />
                    例如，2023年入职，部门编号为1，并且用户编号为2的员工，其工号为20230102
                  </div>
                  <i class="el-icon-question"></i>
                </el-tooltip>
                工号
              </span>
              <el-input v-model="sysUser.workId"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="用户名" prop="userName">
              <span slot="label">
                <el-tooltip content="默认用户名为姓名拼音首字母小写" placement="top">
                  <i class="el-icon-question"></i>
                </el-tooltip>
                用户名
              </span>
              <el-input v-model="sysUser.userName"/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="电话号码" prop="phone">
                <el-input v-model="sysUser.phone"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="电子邮箱" prop="email">
                <el-input v-model="sysUser.email"/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="出生日期" prop="birthday">
                <el-date-picker type="date" placeholder="选择日期" v-model="sysUser.birthday" style="width: 100%;"></el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="入职日期" prop="entryDate">
                <el-date-picker type="date" placeholder="选择日期" v-model="sysUser.entryDate" style="width: 100%;"></el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="身份证号" prop="identification">
          <el-col :span="10">
            <el-input v-model="sysUser.identification"/>
          </el-col>
        </el-form-item>
        <el-form-item label="家庭住址" prop="address">
            <el-input v-model="sysUser.address"/>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="sysUser.status">
            <el-radio :value="1" :label="1">正常</el-radio>
            <el-radio :value="0" :label="0">停用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancel" size="small" icon="el-icon-close">取 消</el-button>
        <el-button type="primary" icon="el-icon-check" @click="saveOrUpdate('dataForm')" size="small">确 定</el-button>
      </span>
    </el-dialog>

    <el-dialog title="分配角色" :visible.sync="dialogRoleVisible">
        <el-form label-width="80px">
            <el-form-item label="用户名">
                <el-input disabled :value="sysUser.userName"></el-input>
            </el-form-item>

            <el-form-item label="角色列表">
                <el-checkbox :indeterminate="isIndeterminate" v-model="checkAll" @change="handleCheckAllChange">全选</el-checkbox>
                <div style="margin: 15px 0;"></div>
                <el-checkbox-group v-model="userRoleIds" @change="handleCheckedChange">
                    <el-checkbox v-for="role in allRoles" :key="role.roleId" :label="role.roleId">{{role.roleName}}</el-checkbox>
                </el-checkbox-group>
            </el-form-item>
        </el-form>
        <div slot="footer">
            <el-button @click="dialogRoleVisible = false" size="small">取消</el-button>
            <el-button type="primary" @click="assignRole" size="small">保存</el-button>
        </div>
    </el-dialog>

  </div>
</template>

<script>
import api from '@/api/system/user'
import roleApi from '@/api/system/role'
import deptApi from '@/api/system/dept'
import postApi from '@/api/system/post'
const defaultForm = {
  userId: '',
  userName: '',
  password: '',
  workId: '',
  name: '',
  sex: '',
  birthday: '',
  address: '',
  phone: '',
  email: '',
  identification: '',
  entryDate: '',
  deptName: '',
  postName: '',
  status: 1
}
let flag = true
let formerName
let formerId
export default {
  data() {
    const checkUsername = (rule, value, callback) => {
      let reg =  /^\w+$/
      if (!value) {
        callback(new Error('用户名不能为空'))
      }
      if (!reg.test(value)) {
        callback(new Error('用户名必须由数字、英文字母或者下划线组成'))
      } else {
        if (!this.sysUser.userId) {
          api.isLive(value).then(response => {
            if (response.code === 211) {
              callback(new Error(response.message))
            } else {
              callback()
            }
          })
        } else {
          if (this.sysUser.userId !== formerId) flag = true
          if (flag) {
            formerName = this.sysUser.userName
            formerId = this.sysUser.userId
            flag = false
          }
          api.isLiveExceptMe(value, formerName).then(response => {
            if (response.code === 211) {
              callback(new Error(response.message))
            } else {
              callback()
            }
          })
        }
      }
    };
    const checkPostName = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请选择职位'))
      } else {
        let postsName = []
        if (this.postList.length !== 0) {
          for (let i = 0; i < this.postList.length; i++) {
            postsName.push(this.postList[i].postName)
          }
          if (postsName.indexOf(value) === -1) callback(new Error('当前职位不属于该部门'))
          else callback()
        } else {
          postApi.getByDeptName(this.sysUser).then(response => {
            for (let i = 0; i < response.data.length; i++) {
              postsName.push(response.data[i].postName)
            }
            if (postsName.indexOf(value) === -1) callback(new Error('当前职位不属于该部门'))
            else callback()
          })
        }
      }
    };
    const checkBirthday = (rule, value, callback) => {
      let date = new Date()
      let validDate = date.setFullYear((date.getFullYear() - 18))
      if (value > validDate) callback(new Error('出生日期不合法'))
      else callback()
    };
    return {
      rules: {
        name: [
          { required: true, message: '姓名不能为空', trigger: 'blur' },
          { pattern: /^[A-Za-z\u4e00-\u9fa5]{1,}$/, message: '请正确填写姓名' }
        ],
        sex: [
          { required: true, message: '请选择性别', trigger: 'change' }
        ],
        deptName: [
          { required: true, message: '请选择部门', trigger: 'change' }
        ],
        postName: [
          { required: true, validator: checkPostName, trigger: 'change' }
        ],
        workId: [
          { required: true,  message: '请填写工号', trigger: 'blur' },
          { pattern: /^[0-9]*$/, message: '工号只能为数字', trigger: 'blur' }
        ],
        userName: [
          { required: true, validator: checkUsername, trigger: 'blur' }
        ],
        phone: [
          { pattern: /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/, message: '请正确填写手机号码', trigger: 'blur' }
        ],
        email: [
          { pattern: /^[A-Za-z\d]+[A-Za-z\d\-_\.]*@([A-Za-z\d]+[A-Za-z\d\-]*\.)+[A-Za-z]{2,4}$/, message: '请正确填写电子邮箱', trigger: 'blur' }
        ],
        birthday: [
          { validator: checkBirthday, trigger: 'change' }
        ],
        entryDate: [
          { required: true, message: '请选择入职日期', trigger: 'change' }
        ],
        identification: [
          { pattern: /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/, message: '请正确填写身份证号', trigger: 'blur' }
        ],
        address: [
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9]+$/, message: '请正确填写家庭住址', trigger: 'blur' }
        ]
      },

      listLoading: true, // 数据是否正在加载
      list: null, // banner列表
      total: 0, // 数据库中的总记录数
      page: 1, // 默认页码
      limit: 5, // 每页记录数
      searchObj: {}, // 查询表单对象

      createTimes: [],

      dialogVisible: false,
      sysUser: defaultForm,
      saveBtnDisabled: false,

      dialogRoleVisible: false,
      allRoles: [], // 所有角色列表
      userRoleIds: [], // 用户的角色ID的列表
      isIndeterminate: false, // 是否是不确定的
      checkAll: false, // 是否全选

      deptList: [], // 部门列表
      postList: [], // 职位列表
      validDeptList: [], // 可用部门列表
      searchPostList: [], // 可用职位列表
    }
  },

  // 生命周期函数：内存准备完毕，页面尚未渲染
  created() {
    this.fetchData()
  },

  methods: {
    // 加载banner列表数据
    fetchData(page = 1) {
      this.page = page
      if(this.createTimes && this.createTimes.length ==2) {
        this.searchObj.createTimeBegin = this.createTimes[0]
        this.searchObj.createTimeEnd = this.createTimes[1]
      }
      // 获取分页数据
      api.getPageList(this.page, this.limit, this.searchObj).then(response => {
        //this.list = response.data.list
        this.list = response.data.records
        this.total = response.data.total
        // 数据加载并绑定成功
        this.listLoading = false
      })
      // 获取所有部门
      deptApi.getAll().then(response => {
        this.deptList = response.data
      })
      // 获取所有职位
      postApi.getAll().then(response => {
        this.searchPostList = response.data
      })
      // 获取可用部门
      deptApi.getValid().then(response => {
        this.validDeptList = response.data
      })
    },

    // 重置查询表单
    resetData() {
      this.searchObj = {}
      this.createTimes = []
      this.fetchData()
    },

    // 根据id删除数据
    removeDataById(id) {
        // debugger
        this.$confirm('此操作将永久删除该记录, 是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(() => { // promise
            // 点击确定，远程调用ajax
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

    //弹出添加表单
    add(){
      this.dialogVisible = true
      this.sysUser = {}
    },
    
	  //编辑
    edit(id) {
      this.dialogVisible = true
      api.getById(id).then(response => {
        this.sysUser = response.data
        this.searchObj.deptName = this.sysUser.deptName
        postApi.getByDeptName(this.searchObj).then(response => {
          this.postList = response.data
        })
      })
    },
    
    //添加或更新
    saveOrUpdate(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (!this.sysUser.userId) {
              this.save()
          } else {
              this.update()
          }
        }
      })
    },

    //添加
    save() {
      api.save(this.sysUser).then(response => {
        this.$message.success('操作成功')
        this.dialogVisible = false
        this.fetchData(this.page)
      })
    },

    //更新
    update() {
      api.updateById(this.sysUser).then(response => {
        this.$message.success('操作成功' || response.message)
        this.dialogVisible = false
        this.fetchData(this.page)
      })
    },

    //切换用户状态
    switchStatus(row) {
        row.status = row.status === 1 ? 0 : 1
        api.updateStatus(row.userId, row.status).then(response => {
            if (response.code) {
                this.$message.success('操作成功' || response.message)
                this.fetchData()
            }
        })
    },

    //展示分配角色
    showAssignRole (row) {
        this.sysUser = row
        this.dialogRoleVisible = true
        roleApi.getRolesByUserId(row.userId).then(response => {
            // console.log(response.data)
            this.allRoles = response.data.allRoles
            this.userRoleIds = response.data.userRoleIds
            this.checkAll = this.userRoleIds.length===this.allRoles.length
            this.isIndeterminate = this.userRoleIds.length>0 && this.userRoleIds.length<this.allRoles.length
        })
    },

    // 全选勾选状态发生改变的监听
    handleCheckAllChange (value) {// value 当前勾选状态true/false
        // 如果当前全选, userRoleIds就是所有角色id的数组, 否则是空数组
        this.userRoleIds = value ? this.allRoles.map(item => item.roleId) : []
        // 如果当前不是全选也不是全不选, 指定为false
        this.isIndeterminate = false
    },

    // 角色列表选中项发生改变的监听
    handleCheckedChange (value) {
        const {userRoleIds, allRoles} = this
        this.checkAll = userRoleIds.length === allRoles.length && allRoles.length>0
        this.isIndeterminate = userRoleIds.length>0 && userRoleIds.length<allRoles.length
    },

    // 分配角色
    assignRole () {
        let assginRoleVo = {
            userId: this.sysUser.userId,
            roleIdList: this.userRoleIds
        }
        roleApi.assignRoles(assginRoleVo).then(response => {
            this.$message.success('分配角色成功' || response.message)
            this.dialogRoleVisible = false
            this.fetchData(this.page)
        })
    },

    // 取消添加/修改
    cancel() {
      this.dialogVisible = false
      location.reload()
    },

    // 查找当前部门下的职位
    selectPost() {
      this.postList = []
      postApi.getByDeptName(this.sysUser).then(response => {
        this.postList = response.data
      })
    }

  }
}
</script>