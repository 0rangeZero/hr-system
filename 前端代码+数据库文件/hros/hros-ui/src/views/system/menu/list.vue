<template>
  <div class="app-container">

    <!-- 工具条 -->
    <div class="tools-div">
      <el-button type="success" icon="el-icon-plus" size="mini" @click="add()">添加菜单</el-button>
    </div>
    <el-table
      :data="sysMenuList"
      style="width: 100%;margin-bottom: 20px;margin-top: 10px;"
      row-key="menuId"
      border
      :default-expand-all="false"
      :tree-props="{children: 'children'}">

      <el-table-column prop="menuName" label="菜单名称" width="160"/>
      <el-table-column label="图标" align="center" width="70">
        <template slot-scope="scope">
          <i :class="scope.row.icon"></i>
        </template>
      </el-table-column>
      <el-table-column prop="perms" label="权限标识" width="210"/>
      <el-table-column prop="path" label="路由地址" width="130"/>
      <el-table-column prop="component" label="组件路径" width="210"/>
      <el-table-column label="状态" width="90" align="center">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.status === 1"
            @change="switchStatus(scope.row)">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="210"/>
      <el-table-column label="操作" width="180" align="center" fixed="right">
        <template slot-scope="scope" align="center">
          <el-button type="success" v-if="scope.row.type !== 2" icon="el-icon-plus" size="mini" @click="add(scope.row)" title="添加下级节点"/>
          <el-button type="primary" icon="el-icon-edit" size="mini" @click="edit(scope.row)" title="修改"/>
          <el-button type="danger" icon="el-icon-delete" size="mini" @click="removeDataById(scope.row.menuId)" title="删除" :disabled="scope.row.children.length > 0"/>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible" width="40%" >
      <el-form ref="dataForm" :model="sysMenu" label-width="150px" size="small" style="padding-right: 40px;">
        <el-form-item label="上级部门" v-if="sysMenu.menuId === ''">
          <el-input v-model="sysMenu.parentName" disabled="true"/>
        </el-form-item>
        <el-form-item label="菜单类型" prop="type">
          <el-radio-group v-model="sysMenu.type" :disabled="typeDisabled">
            <el-radio :label="0" :disabled="type0Disabled">目录</el-radio>
            <el-radio :label="1" :disabled="type1Disabled">菜单</el-radio>
            <el-radio :label="2" :disabled="type2Disabled">按钮</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="菜单名称" prop="menuName">
          <el-input v-model="sysMenu.menuName"/>
        </el-form-item>
        <el-form-item label="图标" prop="icon" v-if="sysMenu.type !== 2">
          <el-select v-model="sysMenu.icon" clearable>
            <el-option v-for="item in iconList" :key="item.class" :label="item.class" :value="item.class">
              <span style="float: left;">
              <i :class="item.class"></i>  <!-- 如果动态显示图标，这里添加判断 -->
              </span>
              <span style="padding-left: 6px;">{{ item.class }}</span>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="path">
              <span slot="label">
                <el-tooltip content="访问的路由地址，如：`user`" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                路由地址
              </span>
          <el-input v-model="sysMenu.path" placeholder="请输入路由地址" />
        </el-form-item>
        <el-form-item prop="component" v-if="sysMenu.type !== 0">
              <span slot="label">
                <el-tooltip content="访问的组件路径，如：`system/user/index`，默认在`views`目录下" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                组件路径
              </span>
          <el-input v-model="sysMenu.component" placeholder="请输入组件路径" />
        </el-form-item>
        <el-form-item v-if="sysMenu.type === 2">
          <el-input v-model="sysMenu.perms" placeholder="请输入权限标识" maxlength="100" />
          <span slot="label">
                <el-tooltip content="控制器中定义的权限字符，如：btn.role.list" placement="top">
                <i class="el-icon-question"></i>
                </el-tooltip>
                权限字符
              </span>
        </el-form-item>
        <el-form-item label="状态" prop="type">
          <el-radio-group v-model="sysMenu.status">
            <el-radio :label="1">正常</el-radio>
            <el-radio :label="0">停用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small" icon="el-icon-close">取 消</el-button>
        <el-button type="primary" icon="el-icon-check" @click="saveOrUpdate()" size="small">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>


<script>
import api from '@/api/system/menu'
const defaultForm = {
  menuId: '',
  parentId: '',
  menuName: '',
  type: 0,
  path: '',
  component: '',
  perms: '',
  icon: '',
  sortValue: 1,
  status: 1
}
export default {
  // 定义数据
  data() {
    return {
      sysMenuList: [],
      expandKeys: [], // 需要自动展开的项

      typeDisabled: false,
      type0Disabled: false,
      type1Disabled: false,
      type2Disabled: false,
      dialogTitle: '',

      dialogVisible: false,
      sysMenu: defaultForm,
      saveBtnDisabled: false,

      iconList: [
        {
          class: "el-icon-s-tools",
        },
        {
          class: "el-icon-user-solid",
        },
        {
          class: "el-icon-menu",
        },
        {
          class: "el-icon-s-check",
        },
        {
          class: "el-icon-user",
        },
        {
          class: "el-icon-s-platform",
        },
        {
          class: "el-icon-s-help",
        },
        {
          class: "el-icon-help",
        },
        {
          class: "el-icon-s-claim",
        },
        {
          class: "el-icon-s-comment",
        },
        {
          class: "el-icon-finished",
        },
        {
          class: "el-icon-date",
        },
        {
          class: "el-icon-wallet",
        },
        {
          class: "el-icon-bank-card",
        },
        {
          class: "el-icon-money",
        },
        {
          class: "el-icon-house",
        },
        {
          class: "el-icon-document",
        },
        {
          class: "el-icon-notebook-2",
        },
        {
          class: "el-icon-coin",
        },
        {
          class: "el-icon-tickets",
        }
      ]
    }
  },

  //当页面加载时获取数据
  created() {
    this.fetchData()
  },

  methods: {
    //调用api层获取数据库中的数据
    fetchData() {
      console.log('加载列表')
      api.findNodes().then(response => {
        this.sysMenuList = response.data
        // console.log(this.sysMenuList)
      })
    },

    //根据id删除数据
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
        this.fetchData()
        this.$message.success('删除成功' || response.message)
      }).catch(() => {
         this.$message.info('取消删除')
      })
    },

    //弹出添加或更新的表单
    add(row){
      debugger
      this.typeDisabled = false
      this.dialogTitle = '添加下级节点'
      this.dialogVisible = true

      this.sysMenu = Object.assign({}, defaultForm)
      this.sysMenu.menuId = ''
      if(row) {
        this.sysMenu.parentId = row.menuId
        this.sysMenu.parentName = row.menuName
        //this.sysMenu.component = 'ParentView'
        if(row.type === 0) {
          this.sysMenu.type = 1
          this.typeDisabled = false
          this.type0Disabled = true
          this.type1Disabled = false
          this.type2Disabled = true
        } else if(row.type === 1) {
          this.sysMenu.type = 2
          this.typeDisabled = true
        }
      } else {
        this.dialogTitle = '添加目录节点'
        this.sysMenu.type = 0
        this.sysMenu.component = 'Layout'
        this.sysMenu.parentId = 0
        this.typeDisabled = true
      }
    },

    //编辑
    edit(row) {
      debugger
      this.dialogTitle = '修改菜单'
      this.dialogVisible = true

      this.sysMenu = Object.assign({}, row)
      this.typeDisabled = true
    },
	
    //添加或更新
    saveOrUpdate() {
      if(this.sysMenu.type === 0 && this.sysMenu.parentId !== 0) {
        this.sysMenu.component = 'ParentView'
      }
      this.$refs.dataForm.validate(valid => {
        if (valid) {
          this.saveBtnDisabled = true // 防止表单重复提交
          if (!this.sysMenu.menuId) {
            this.save()
          } else {
            this.update()
          }
        }
      })
    },

    //添加
    save() {
      api.save(this.sysMenu).then(response => {
        this.$message.success('添加成功' || response.message)
        this.dialogVisible = false
        this.fetchData(this.page)
      })
    },

    //更新
    update() {
      api.updateById(this.sysMenu).then(response => {
        this.$message.success('修改成功' || response.message)
        this.dialogVisible = false
        this.fetchData()
      })
    },

    //切换菜单状态
    switchStatus(row) {
        row.status = row.status === 1 ? 0 : 1
        api.updateStatus(row.menuId, row.status).then(response => {
            if (response.code) {
                this.$message.success('操作成功' || response.message)
                this.fetchData()
            }
        })
    }
  }
}
</script>