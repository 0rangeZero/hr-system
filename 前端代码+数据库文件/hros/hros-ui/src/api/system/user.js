import request from '@/utils/request'

const api_name = '/system/user'

export default {
    getPageList(page, limit, searchObj) {
        return request({
            url: `${api_name}/${page}/${limit}`,
            method: 'get',
            params: searchObj // url查询字符串或表单键值对
        })
    },
    getById(id) {
        return request({
            url: `${api_name}/get/${id}`,
            method: 'get'
        })
    },
    save(user) {
        return request({
            url: `${api_name}/save`,
            method: 'post',
            data: user
        })
    },
    updateById(user) {
        return request({
            url: `${api_name}/update`,
            method: 'put',
            data: user
        })
    },
    removeById(id) {
        return request({
            url: `${api_name}/remove/${id}`,
            method: 'delete'
        })
    },
    //更新用户状态
    updateStatus(id, status) {
        return request({
            url: `${api_name}/updateStatus/${id}/${status}`,
            method: 'get'
        })
    },
    //查看用户是否存在
    isLive(username) {
        return request({
            url: `${api_name}/isLive/${username}`,
            method: 'get'
        })
    },
    //查看除了自己的用户是否存在
    isLiveExceptMe(username, formerName) {
        return request({
            url: `${api_name}/isLiveExceptMe/${username}/${formerName}`,
            method: 'get'
        })
    },
    //根据token获取用户信息
    getByToken() {
        return request({
            url: `${api_name}/selectByToken`,
            method: 'get',
        })
    },
    //修改密码
    reset(user) {
        return request({
            url: `${api_name}/updatePwd`,
            method: 'put',
            data: user
        })
    },
    //获取用户打卡日期
    selectWorkDate() {
        return request({
            url: `${api_name}/selectWorkDate`,
            method: 'get',
        })
    },
    //获取用户请假日期
    selectLeaveDate() {
        return request({
            url: `${api_name}/selectLeaveDate`,
            method: 'get',
        })
    },
    //打卡
    workDate(date) {
        return request({
            url: `${api_name}/clock/${date}`,
            method: 'put',
        })
    },
    // 账套修改
    updateSalary(userId, salaryName) {
        return request({
            url: `${api_name}/updateSalary/${userId}/${salaryName}`,
            method: 'put',
        })
    },
    // 获取工资发放记录
    getPayOff(page, limit, searchObj) {
        return request({
            url: `${api_name}/getPayOffList/${page}/${limit}`,
            method: 'get',
            params: searchObj
        })
    },
    // 获取个人工资单
    getMyPayOff(page, limit, searchObj) {
        return request({
            url: `${api_name}/getPayMyOffList/${page}/${limit}`,
            method: 'get',
            params: searchObj
        })
    }
}