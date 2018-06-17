<template>
  <div id="list">
    <input v-model="keyword" placeholder="search...">
    <table>
      <tbody>
        <tr v-for="item in list" :key="item">
          <td id="items">{{ item }}</td>
          <td id="actions">
              <span><font-awesome-icon icon="pencil-alt"/></span>
              <span><font-awesome-icon icon="trash-alt"/></span>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import FontAwesomeIcon from '@fortawesome/vue-fontawesome'

export default {
  data() {
    return {
      keyword: '',
      list: ['foo', 'bar', 'baz', 'qux']
    }
  },

  components: {
    FontAwesomeIcon
  }
}
</script>

<style>
table {
  width: 80%;
  margin: 20px auto;
  border-radius: 3px;
  background-color: white;
  opacity: .9;
  font-weight: 600;
  font-size: 14px;
}

td {
  padding: 10px;
}

#items {
  text-align: left;
}

#actions {
  width: 20%;
  float: right;
  display: inline-flex;
  justify-content: space-between;
}
</style>
