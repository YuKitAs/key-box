<template>
  <div id="app">
    <h2>Hello world!</h2>
    <input v-model="keyword">
    <div>{{ keyword }}</div>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
    return {
      keyword: ''
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
