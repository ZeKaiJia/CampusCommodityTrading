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
      cdata: {
        xData: ["测试", "下单", "咨询", "上货", "注册", "查询"],
        seriesData: [
          { value: 128, name: "测试" },
          { value: 420, name: "下单" },
          { value: 690, name: "咨询" },
          { value: 100, name: "上货" },
          { value: 268, name: "注册" },
          { value: 1012, name: "查询" }
        ]
      }
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
