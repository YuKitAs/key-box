<template>
  <div id="list">
    <input v-model="keyword" placeholder="search...">
    <div ref="addButton" class="btn btn-add" @click="addKey()"><font-awesome-icon icon="plus"/></div>
    <table>
      <tbody>
        <tr v-for="item in list" :key="item.id">
          <td class="items"><input ref="keyInput" class="key" v-model="item.key" :disabled="!isEditing(editingId, item.id)"></td>
          <td class="actions">
              <span class="btn btn-edit" @click="editKey(item.id)" :hidden="isEditing(editingId, item.id)"><font-awesome-icon icon="pencil-alt"/></span>
              <span class="btn btn-confirm" @click="saveKey(item.key)" :hidden="!isEditing(editingId, item.id)"><font-awesome-icon icon="check"/></span>
              <span class="btn btn-delete" @click="deleteKey(item.id)" :hidden="isEditing(editingId, item.id)"><font-awesome-icon icon="trash-alt"/></span>
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
      list: [{'key': 'foo', 'id': 0}, {'key': 'bar', 'id': 1}, {'key': 'baz', 'id': '2'}],
      editingId: null
    }
  },

  methods: {
    addKey() {
      this.list.push({'key': 'qux', 'id': Math.floor((Math.random() * 100) + 1)})
    },

    editKey(id) {
      this.editingId = id
    },

    isEditing(editingId, id) {
      return editingId === id
    },

    saveKey(key) {
      this.editingId = null
    },

    deleteKey(id) {
      let index = this.list.findIndex(e => e['id'] === id)

      if (index !== -1) {
        this.list.splice(index, 1)
      }
    }
  },

  components: {
    FontAwesomeIcon
  }
}
</script>

<style scoped>
.btn {
  cursor: pointer;
}

.btn-add {
  position: fixed;
  right: 10%;
  bottom: 5%;
  z-index: 1;
}

.btn-delete {
  margin-left: 10px;
}

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

.items {
  text-align: left;
}

.key {
  border: none;
  background-color: transparent;
}

.actions {
  width: 30%;
  text-align: right;
  display: inline-flex;
  justify-content: space-around;
}
</style>
