<template>
  <div>
    <Chart :cdata="cdata" />
  </div>
</template>

<script>
import Chart from './chart.vue';
export default {
  data () {
    return {
      cdata: [
        {
          // 名字需要与 “common/map/fujian.js” 地图数据文件里面定义的一一对应，不能是 “福州” 或者 “闽” 之类的缩写
          name: '杭州市',
          value: 10,
          elseData:{
            // 这里放置地图 tooltip 里想显示的数据
          }
        },
        {
          name: '宁波市',
          value: 9,
        },
        {
          name: '温州市',
          value: 8,
        },
        {
          name: '嘉兴市',
          value: 7,
        },
        {
          name: '湖州市',
          value: 6,
        },
        {
          name: '绍兴市',
          value: 5,
        },
        {
          name: '金华市',
          value: 4,
        },
        {
          name: '衢州市',
          value: 3,
        },
        {
          name: '舟山市',
          value: 2,
        },
        {
          name: '台州市',
          value: 1,
        },
        {
          name: '丽水市',
          value: 0,
        }
      ]
    }
  },
  components: {
    Chart,
  },
  mounted () {
  },
  methods: {
  }
}
</script>

<style lang="scss" scoped>
</style>
