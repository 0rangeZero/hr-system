import request from '@/utils/request'

const api_name = '/system/clock'

export default {
    // 获取打卡信息分页列表
    getPageList(page, limit, searchObj) {
        return request({
            url: `${api_name}/${page}/${limit}`,
            method: 'get',
            params: searchObj
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
}