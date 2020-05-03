<template>
  <div class="hello">
    <h1>{{ msg }}</h1>

    <form v-on:submit.prevent>
      <div class="form-group">
        <input
          type="text"
          class="form-control"
          v-model="item"
          placeholder="Enter your item to do"
          v-on:keydown.enter="addToList()"
        />
      </div>
      <button type="button" class="btn btn-primary btn-lg" v-on:click="addToList()">Add To List</button>
    </form>

    <div class="text-left" v-if="items.length">
      <h3>Things To Do</h3>
      <table class="table">
        <tbody>
          <tr v-for="(item, index) in items" :key="item">
            <td>
              {{index + 1}} - {{item}}
              <button
                type="button"
                class="btn-danger pull-right"
                v-on:click="deleteItem(item)"
              >Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  name: "HelloWorld",
  props: {
    msg: String
  },
  data: function() {
    return {
      item: "",
      items: [],
      url: "http://localhost:8080/todo"
    };
  },
  methods: {
    addToList: function() {
      this.axios
        .get(this.url + "/add?item=" + this.item)
        .then(() => {
          console.log("Item added : " + this.item);
          this.item = "";
          this.getAll();
        })
        .catch(err => {
          console.err("Could not add item : " + this.item, err);
        });
    },
    deleteItem: function(item) {
      this.axios
        .get(this.url + "/delete?item=" + item)
        .then(() => {
          console.log("Item deleted : " + item);
          this.getAll();
        })
        .catch(err => {
          console.err("Could not delete item : " + item, err);
        });
    },
    getAll: function () {
      this.axios
        .get(this.url + "/list")
        .then((response) => {
          console.log(response.data);
          this.items = response.data;
        })
        .catch(err => {
          console.err("Could not get list", err);
        });  
    }
  },
  created: function() {
    this.getAll();
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
