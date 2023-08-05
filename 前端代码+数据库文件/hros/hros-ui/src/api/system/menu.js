import request from '@/utils/request'

const api_name = '/system/menu'

export default {
    // 获取权限(菜单/功能)列表
    findNodes() {
        return request({
            url: `${api_name}/findNodes`,
            method: 'get'
        })
    },
    // 删除
    removeById(id) {
        return request({
            url: `${api_name}/remove/${id}`,
            method: "delete"
        })
    },
    // 保存
    save(menu) {
        return request({
            url: `${api_name}/save`,
            method: "post",
            data: menu
        })
    },
    // 更新
    updateById(menu) {
        return request({
            url: `${api_name}/update`,
            method: "put",
            data: menu
        })
    },
    // 查看某个角色的权限列表
    toAssign(roleId) {
        return request({
            url: `${api_name}/toAssign/${roleId}`,
            method: 'get'
        })
    },
    // 给某个角色授权
    doAssign(assginMenuVo) {
        return request({
            url: `${api_name}/doAssign`,
            method: "post",
            data: assginMenuVo
        })
    },
    //更新菜单状态
    updateStatus(id, status) {
        return request({
        url: `${api_name}/updateStatus/${id}/${status}`,
        method: 'get'
        })
    }
}