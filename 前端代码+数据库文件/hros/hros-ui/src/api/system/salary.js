import request from '@/utils/request'

const api_name = '/system/salary'

export default {
    // 获取账套分页列表
    getPageList(page, limit, searchObj) {
        return request({
            url: `${api_name}/${page}/${limit}`,
            method: 'get',
            params: searchObj
        })
    },
    // 添加账套
    save(salary) {
        return request({
            url: `${api_name}/save`,
            method: 'post',
            data: salary
        })
    },
    // 根据id查询查询账套
    getById(id) {
        return request({
            url: `${api_name}/get/${id}`,
            method: 'get',
        })
    },
    // 修改账套
    update(salary) {
        return request({
            url: `${api_name}/update`,
            method: 'put',
            data: salary
        })
    },
    // 删除账套
    removeById(id) {
        return request({
            url: `${api_name}/remove/${id}`,
            method: 'delete'
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
    // 根据部门名称获取对应的账套信息
    getByDeptName(deptName) {
        return request({
            url: `${api_name}/getByDeptName/${deptName}`,
            method: `get`,
        })
    },
    // 工资发放
    pay(payoff) {
        return request({
            url: `${api_name}/payoff`,
            method: 'post',
            data: payoff
        })
    },
    // 获取工资发放
    getPayTime(idList) {
        return request({
            url: `${api_name}/getPayTime`,
            method: `post`,
            data: idList
        })
    }
}