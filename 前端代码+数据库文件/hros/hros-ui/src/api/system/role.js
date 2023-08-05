import request from '@/utils/request'

const api_name = '/system/role'

export default {
    // 获取角色分页列表
    getPageList(page, limit, searchObj) {
        return request({
            url: `${api_name}/${page}/${limit}`,
            method: 'get',
            params: searchObj
        })
    },
    // 删除角色
    removeById(id) {
        return request({
            url: `${api_name}/remove/${id}`,
            method: 'delete'
        })
    },
    // 添加角色
    save(role) {
        return request({
            url: `${api_name}/save`,
            method: 'post',
            data: role
        })
    },
    // 根据id查询查询角色
    getById(id) {
        return request({
            url: `${api_name}/get/${id}`,
            method: 'get',
        })
    },
    // 修改角色
    update(role) {
        return request({
          url: `${api_name}/update`,
          method: 'put',
          data: role
        })
    },
    // 批量删除
    batchRemove(idList) {
        return request({
          url: `${api_name}/batchRemove`,
          method: `delete`,
          data: idList
        })
    },
    //根据用户id查询用户已分配的角色
    getRolesByUserId(userId) {
        return request({
            url: `${api_name}/toAssign/${userId}`,
            method: 'get'
        })
    },
    //分配角色
    assignRoles(assginRoleVo) {
        return request({
            url: `${api_name}/doAssign`,
            method: 'post',
            data: assginRoleVo
        })
    }
}