<template>
  <div id="login">
    <input :type="passwordType" v-model="password" placeholder="Password">
    <span><font-awesome-icon :icon="visibilityIcon" @click="switchVisibility()"/></span>
    <div><button class="btn btn-login" @click="verifyPassword()">Login</button></div>
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
    },

    verifyPassword() {
      if (this.password === 'n0password') {
        this.$router.replace('/list')
      }
    }
  },

  components: {
    FontAwesomeIcon
  }
}
</script>

<style scoped>
input {
  width: 100px;
  margin-top: 10px;
}

.btn-login {
  margin-top: 20px;
}

input:focus, button:focus {
  outline: none;
}
</style>
