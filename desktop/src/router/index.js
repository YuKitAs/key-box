import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/components/Login'
import List from '@/components/List'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/list',
      name: 'List',
      component: List
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
