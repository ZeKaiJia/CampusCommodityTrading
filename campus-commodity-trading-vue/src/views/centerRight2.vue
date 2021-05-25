<template>
  <div id="centerRight2">
    <div class="bg-color-black">
      <div class="d-flex pt-2 pl-2">
        <span style="color:#5cd9e8">
          <icon name="align-left"></icon>
        </span>
        <span class="fs-xl text mx-2">大宗交易渠道分析</span>
      </div>
      <div class="d-flex jc-center body-box" style=" margin-top: 0;">
        <dv-capsule-chart :config="config" style="width: 100%;height:2rem" />
        <!-- ---------------------------------------- -->
        <centerRight2Chart1 />
      </div>
    </div>
  </div>
</template>

<script>
import centerRight2Chart1 from "@/components/echart/centerRight/centerRightChart";

export default {
  data() {
    return {
      config: {
        data: [
          {
            name: "北京",
            value: 167
          },
          {
            name: "上海",
            value: 133
          },
          {
            name: "深圳",
            value: 113
          },
          {
            name: "广州",
            value: 90
          },
          {
            name: "杭州",
            value: 68
          }
        ]
      }
    };
  },
  components: { centerRight2Chart1 },
  mounted() {},
  methods: {}
};
</script>

<style lang="scss">
#centerRight2 {
  padding: 0.0625rem;
  height: 5rem;
  min-width: 3.75rem;
  border-radius: 0.0625rem;
  .bg-color-black {
    padding: 0.0625rem;
    height: 5.0625rem;
    border-radius: 0.125rem;
  }
  .text {
    color: #c3cbde;
  }
  .body-box {
    border-radius: 0.125rem;
    overflow: hidden;
  }
}
</style>
