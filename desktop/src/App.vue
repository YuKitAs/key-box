<template>
  <div id="app">
    <h2>Key Box</h2>
    <input v-model="keyword" placeholder="search...">
    <div>{{ keyword }}</div>
    <list/>
  </div>
</template>

<script>
import List from '@/components/List'

export default {
  name: 'App',

  data() {
    return {
      keyword: ''
    }
  },

  components: {
    List
  }
}
</script>

<style>
body {
  background-color: #12b886;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
