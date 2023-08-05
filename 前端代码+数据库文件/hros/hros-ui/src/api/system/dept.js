import request from '@/utils/request'

const api_name = '/system/dept'

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
    //更新用户状态
    updateStatus(id, status) {
        return request({
            url: `${api_name}/updateStatus/${id}/${status}`,
            method: 'get'
        })
    },
    // 获取所有部门
    getAll() {
        return request({
            url: `${api_name}/findAll`,
            method: 'get'
        })
    },
    // 获取可用的部门
    getValid() {
        return request({
            url: `${api_name}/findValid`,
            method: 'get'
        })
    }
}