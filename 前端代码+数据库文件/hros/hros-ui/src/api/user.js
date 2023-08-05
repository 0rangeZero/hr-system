import request from '@/utils/request'

export function login(data) {
  return request({
    url: '/system/index/login',
    method: 'post',
    data: data
  })
}

export function getInfo(token) {
  return request({
    url: '/system/index/info',
    method: 'get',
    params: { token }
  })
}

export function logout() {
  return request({
    url: '/system/index/logout',
    method: 'post'
  })
}
