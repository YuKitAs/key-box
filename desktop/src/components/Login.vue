<template>
  <div id="login">
    <input :type="passwordType" v-model="password" placeholder="Password">
    <span><font-awesome-icon :icon="visibilityIcon" @click="switchVisibility()"/></span>
    <div><router-link to="/list" tag="button">Login</router-link></div>
  </div>
</template>

<script>
import FontAwesomeIcon from '@fortawesome/vue-fontawesome'

export default {
  data() {
    return {
      password: '',
      passwordType: 'password',
      visibilityIcon: 'eye'
    }
  },

  methods: {
    switchVisibility() {
      this.passwordType = this.passwordType === 'password' ? 'text' : 'password'
      this.visibilityIcon = this.visibilityIcon === 'eye' ? 'eye-slash' : 'eye'
    }
  },

  components: {
    FontAwesomeIcon
  }
}
</script>

<style>
input {
  width: 100px;
  margin-top: 10px;
}

button {
  margin-top: 20px;
}

input:focus, button:focus {
  outline: none;
}
</style>
