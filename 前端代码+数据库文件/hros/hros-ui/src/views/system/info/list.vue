<template>
  <div class="app-container">

      <el-form ref="dataForm" :model="user" :rules="rules" label-width="100px" style="padding-right: 40px;">
        <el-row>
          <el-col :span="6">
            <el-form-item label="姓名" prop="name">
                <el-input style="width: 205px" v-model="user.name"/>
            </el-form-item>
            <el-form-item label="性别" prop="sex">
                <el-select v-model="user.sex" placeholder="性别">
                  <el-option label="男" value="男"></el-option>
                  <el-option label="女" value="女"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="部门" prop="deptName">
              <el-select v-model="user.deptName" @change="selectPost" :disabled="true" placeholder="请选择隶属部门">
                  <el-option v-for="item in validDeptList" :key="item.deptId" :label="item.deptName" :value="item.deptName">
                  </el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="职位" prop="postName">
              <el-select v-model="user.postName" :disabled="true" placeholder="请选择所任职位">
                  <el-option v-for="item in postList" :key="item.postId" :label="item.postName" :value="item.postName">
                  </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          
          <el-col :span="8">
            <el-form-item>
              <el-row>
                <pan-thumb :image="user.headUrl" />
              </el-row>
              <el-row style="margin-top: 15px">
                <el-col style="margin-left: 15px">
                  <el-button type="info" icon="el-icon-upload" @click="imagecropperShow=true" plain>
                    头像上传
                  </el-button>
                </el-col>
              </el-row>

              <image-cropper
                v-show="imagecropperShow"
                :key="imagecropperKey"
                :width="300"
                :height="300"
                :url="BASE_API+'/hross/file/uploadOssHeadUrl'"
                field="file"
                lang-type="zh"
                @close="close"
                @crop-upload-success="cropSuccess"
              />
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
              <el-input v-model="user.workId" :disabled="true"/>
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
              <el-input v-model="user.userName"/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="电话号码" prop="phone">
                <el-input v-model="user.phone"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="电子邮箱" prop="email">
                <el-input v-model="user.email"/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="出生日期" prop="birthday">
                <el-date-picker type="date" placeholder="选择日期" v-model="user.birthday" style="width: 100%;"></el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="入职日期" prop="entryDate">
                <el-date-picker type="date" placeholder="选择日期" v-model="user.entryDate" :disabled="true" style="width: 100%;"></el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="身份证号" prop="identification">
          <el-col :span="10">
            <el-input style="width: 525px" v-model="user.identification"/>
          </el-col>
        </el-form-item>
        <el-form-item label="家庭住址" prop="address">
          <el-input v-model="user.address"/>
        </el-form-item>
        <el-form-item>
          <el-row>
            <el-col :span="1">
              <el-button type="primary" icon="el-icon-check" @click="save('dataForm')">保 存</el-button>
            </el-col>
            <el-col :span="1" offset="2">
              <el-button type="warning" icon="el-icon-refresh-right" @click="pwdReset">修改密码</el-button>
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>

      <el-dialog title="修改密码" :visible.sync="dialogVisible" width="30%" >
        <el-form ref="pwdForm" :model="user" :rules="pwdRules" label-width="150px" size="small" style="padding-right: 80px;">
            <el-form-item label="旧密码" prop="oldPwd">
                <el-input v-model="user.oldPwd" show-password/>
            </el-form-item>
            <el-form-item label="新密码" prop="newPwd">
                <el-input v-model="user.newPwd" show-password/>
            </el-form-item>
            <el-form-item label="确认密码" prop="confirmPwd">
                <el-input v-model="user.confirmPwd" show-password/>
            </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="cancel" size="small" icon="el-icon-close">取 消</el-button>
          <el-button type="primary" icon="el-icon-check" @click="reset('pwdForm')" size="small">确 定</el-button>
        </span>
      </el-dialog>

  </div>
</template>

<script>
import userApi from '@/api/system/user'
import deptApi from '@/api/system/dept'
import postApi from '@/api/system/post'
import md5Api from '@/api/md5'
import ImageCropper from '@/components/ImageCropper'
import PanThumb from '@/components/PanThumb'
const defaultForm = {
  userId: '',
  userName: '',
  password: '',
  oldPwd: '',
  newPwd: '',
  confirmPwd: '',
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
  headUrl: '',
  status: 1
}
let flag = true
let formerName
let formerId
export default {
  components: { ImageCropper, PanThumb },
  data() {
    const checkUsername = (rule, value, callback) => {
      let reg =  /^\w+$/
      if (!value) {
        callback(new Error('用户名不能为空'))
      }
      if (!reg.test(value)) {
        callback(new Error('用户名必须由数字、英文字母或者下划线组成'))
      } else {
        if (!this.user.userId) {
          userApi.isLive(value).then(response => {
            if (response.code === 211) {
              callback(new Error(response.message))
            } else {
              callback()
            }
          })
        } else {
          if (this.user.userId !== formerId) flag = true
          if (flag) {
            formerName = this.user.userName
            formerId = this.user.userId
            flag = false
          }
          userApi.isLiveExceptMe(value, formerName).then(response => {
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
          postApi.getByDeptName(this.user).then(response => {
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
    const checkPwd = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入旧密码'))
      } else if (!(md5Api.MD5(value) === this.user.password)) {
        callback(new Error('密码错误'))
      } else {
        callback()
      }
    };
    const checkNewPwd = (rule, value, callback) => {
      let reg = /^[A-Za-z0-9]\w{5,17}$/
      if (!value) {
        callback(new Error('请输入新密码'))
      } else if (value.length < 6 || value.length > 18) {
        callback(new Error('密码长度必须在6~18之间'))
      } else if (!reg.test(value)) {
        callback(new Error('密码只能包含字母、数字和下划线'))
      } else {
        callback()
      }
    };
    const checkConfirmPwd = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请再次输入密码'))
      } else if (!(value === this.user.newPwd)) {
        callback(new Error('两次输入密码不一致!'))
      } else {
        callback()
      }
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
        identification: [
          { pattern: /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/, message: '请正确填写身份证号', trigger: 'blur' }
        ],
        address: [
          { pattern: /^[\u4e00-\u9fa5a-zA-Z0-9]+$/, message: '请正确填写家庭住址', trigger: 'blur' }
        ]
      },
      pwdRules: {
        oldPwd: [
          { required: true, validator: checkPwd, trigger: 'blur' }
        ],
        newPwd: [
          { required: true, validator: checkNewPwd, trigger: 'blur' }
        ],
        confirmPwd: [
          { required: true, validator: checkConfirmPwd, trigger: 'blur' }
        ],
      },

      user: defaultForm,
      imagecropperShow: false,
      imagecropperKey: 0,
      BASE_API: process.env.VUE_APP_BASE_API,

      dialogVisible: false, //弹窗显示
      searchObj: {}, // 查询表单对象
      validDeptList: [], // 可用部门列表
      postList: [] // 职位列表
    }
  },
  created() {
    userApi.getByToken().then(response => {
      this.fetchData(response.data.userId)
    })
  },
  methods: {
    cropSuccess(resData) {
      this.imagecropperShow = false
      this.imagecropperKey = this.imagecropperKey + 1
      this.user.headUrl = resData
      this.$message.success('上传成功，请点击 [保存] 以存储头像，头像将在下次登录时生效')
    },
    close() {
      this.imagecropperShow = false
      this.imagecropperKey = this.imagecropperKey + 1
    },
    fetchData(id) {
      userApi.getById(id).then(response => {
        this.user = response.data
        if(this.user.headUrl === null ||this.user.headUrl === '')
          this.user.headUrl = 'https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png'
        this.searchObj.deptName = this.user.deptName
        postApi.getByDeptName(this.searchObj).then(response => {
          this.postList = response.data
        })
        // 获取可用部门
        deptApi.getValid().then(response => {
          this.validDeptList = response.data
        })
      })
    },
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          userApi.updateById(this.user).then(response => {
            this.$message.success('保存成功')
            this.fetchData(this.user.userId)
          })
        }
      })
    },
    // 查找当前部门下的职位
    selectPost() {
      this.postList = []
      postApi.getByDeptName(this.user).then(response => {
        this.postList = response.data
      })
    },
    // 修改密码
    reset(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          userApi.reset(this.user).then(response => {
            this.$message.success('修改成功，请重新登录')
            this.dialogVisible = false
            this.logout()
          })
        }
      })
    },
    pwdReset() {
      this.dialogVisible = true
    },
    // 取消修改密码
    cancel() {
      this.dialogVisible = false
      location.reload()
    },
    async logout() {
      await this.$store.dispatch('user/logout')
      this.$router.push(`/login`) // ?redirect=${this.$route.fullPath}
    }
  }
}
</script>

<style scoped>
  .headUrl{
    width: 200px;
    height: 200px;
    border-radius: 50%;
  }
</style>