<template>
  <div class="mx-auto container" v-if="order">
    <div class="bg-white py-40 rounded text-center px-10">
      <div v-if="order.status === 'SUCCEED'">
        <img src="~/assets/images/check.svg" class="w-24 mx-auto block" />
        <div class="text-[#32BEA6] text-2xl font-bold mt-10 mb-2">
          Giao dịch Thành công
        </div>
        <div class="text-[#192760] text-lg">
          Giao dịch đã thành công. Vui lòng kiểm tra tài khoản của bạn
        </div>
      </div>
      <div v-else>
        <img src="~/assets/images/cancel.svg" class="w-24 mx-auto block" />
        <div class="text-[#E21B1B] text-2xl font-bold mt-10 mb-2">
          Giao dịch bị huỷ
        </div>
        <div class="text-[#192760] text-lg">
          Giao dịch bị hủy do đã quá thời gian giao dịch.
        </div>
      </div>

      <div class="mt-40" v-if="redirectUrl">
        <a
          :href="redirectUrl"
          class="bg-[#1e427e] block rounded w-80 mx-auto py-2 text-white uppercase"
        >
          Quay lại trang trước
        </a>
        <div class="text-center italic text-xs mt-2">
          Hệ thống tự động chuyển hướng sau {{ timer }}s!
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      timer: 10,
    };
  },

  mounted() {
    if (this.redirectUrl) {
      const interval = setInterval(() => {
        if (this.timer === 0) window.location.href = this.redirectUrl;
        else this.timer -= 1;
      }, 1000);
    }
  },
  props: {
    order: {
      type: Object,
      default: null,
    },
  },
  computed: {
    redirectUrl() {
      return this.$route.query.redirectURL || null;
    },
  },
};
</script>
