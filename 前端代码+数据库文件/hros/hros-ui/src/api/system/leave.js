import request from '@/utils/request'

const api_name = '/system/leave'

export default {
    // 获取请假申请分页列表
    getPageList(page, limit, searchObj) {
        return request({
            url: `${api_name}/${page}/${limit}`,
            method: 'get',
            params: searchObj
        })
    },
    // 添加申请
    save(leave) {
        return request({
            url: `${api_name}/save`,
            method: 'post',
            data: leave
        })
    },
    // 根据id获取请假信息
    getById(id) {
        return request({
            url: `${api_name}/get/${id}`,
            method: 'get',
        })
    },
    // 申请修改
    update(leave) {
        return request({
          url: `${api_name}/update`,
          method: 'put',
          data: leave
        })
    },
    // 根据id删除
    removeById(id) {
        return request({
            url: `${api_name}/remove/${id}`,
            method: 'delete'
        })
    },
    // 获取请假审批分页数据
    getList(page, limit, searchObj, passedNum) {
        return request({
            url: `${api_name}/getList/${page}/${limit}/${passedNum}`,
            method: 'get',
            params: searchObj
        })
    },
    // 申请通过
    pass(leaveId, userId) {
        return request({
            url: `${api_name}/pass/${leaveId}/${userId}`,
            method: 'put',
        })
    },
    // 申请驳回
    reject(id) {
        return request({
            url: `${api_name}/reject/${id}`,
            method: 'put',
        })
    },
    // 撤销申请
    revocation(leaveId, userId) {
        return request({
            url: `${api_name}/revocation/${leaveId}/${userId}`,
            method: 'put',
        })
    }
}