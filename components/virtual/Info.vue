<template>
  <div class="pb-20">
    <div class="p-5 bg-white mt-5 grid grid-cols-1 md:grid-cols-2 gap-5">
      <div v-if="order">
        <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
          Ngân hàng:
        </label>
        <div
          class="flex justify-between border-0 border-b border-solid border-[#F2F2F2] pb-1 items-center"
        >
          <div>
            {{ order?.vitualTx?.bankCode }}
          </div>
        </div>
        <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
          Người nhận:
        </label>
        <div
          class="flex justify-between border-0 border-b border-solid border-[#F2F2F2] pb-1 items-center"
        >
          <div>
            {{ order?.vitualTx?.bankAccountName }}
          </div>
          <div
            class="bg-[#F5F8FA] text-[#3554D1] cursor-pointer px-5 py-2 text-xs rounded"
            @click="copyText(order?.vitualTx?.bankAccountName)"
            variant="outline-primary"
          >
            Sao chép
          </div>
        </div>

        <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
          Số tài khoản:
        </label>
        <div
          class="flex justify-between border-0 border-b border-solid border-[#F2F2F2] pb-1 items-center"
        >
          <div>{{ order?.vitualTx?.bankAccountNo }}</div>
          <div
            class="bg-[#F5F8FA] text-[#3554D1] cursor-pointer px-5 py-2 text-xs rounded"
            @click="copyText(order?.vitualTx?.bankAccountNo)"
            variant="outline-primary"
          >
            Sao chép
          </div>
        </div>

        <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
          Số tiền:
        </label>
        <div
          class="flex justify-between border-0 border-b border-solid border-[#F2F2F2] pb-1 items-center"
        >
          <div>
            {{ order?.amount | formatPrice }}
          </div>
          <div
            class="bg-[#F5F8FA] text-[#3554D1] cursor-pointer px-5 py-2 text-xs rounded"
            @click="copyText(order?.amount)"
            variant="outline-primary"
          >
            Sao chép
          </div>
        </div>

        <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
          Nội dung chuyển khoản:
        </label>
        <div
          class="flex text-[#D0600F] justify-between border-0 border-b border-solid border-[#F2F2F2] pb-1 items-center"
        >
          <div>
            {{ order?.code }}
          </div>
          <div
            class="bg-[#F5F8FA] text-[#3554D1] cursor-pointer px-5 py-2 text-xs rounded"
            @click="copyText(order?.code)"
            variant="outline-primary"
          >
            Sao chép
          </div>
        </div>
      </div>
      <div>
        <img
          v-if="order?.vitualTx?.qrUrl"
          :src="order?.vitualTx?.qrUrl"
          class="w-[300px] mx-auto"
        />
      </div>
    </div>
    <div class="p-5 bg-white mt-5">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
        <div class="bg-[#F5F8FA] drop-shadow-md p-5">
          <div class="flex items-center text-[20px] font-bold mb-5">
            <img src="~/assets/images/list-alt.svg" class="mr-3 h-6" />
            Hướng dẫn
          </div>
          <ul class="list-disc pl-6">
            <li>
              Chuyển khoản tới ngân hàng đúng thông tin hoặc quét mã QR trong
              ứng dụng ngân hàng.
            </li>
            <li>Nhập đúng nội dung chuyển khoản.</li>
            <li>
              Vui lòng liên hệ với trung tâm hỗ trợ nếu giao dịch chưa cập nhật
              trạng thái.
            </li>
          </ul>
        </div>
        <div class="bg-[#F5F8FA] drop-shadow-md p-5 text-[#D0600F]">
          <div class="flex items-center text-[20px] font-bold mb-5">
            <img src="~/assets/images/warning.svg" class="mr-3 h-6" />
            Chú ý
          </div>
          <ul class="list-disc pl-6">
            <li>Nhập đúng nội dung chuyển khoản</li>
            <li>
              Không nhập thêm các nội dung khác như Fund, Forex, Crypto...
            </li>
            <li>
              Hệ thống sẽ không chịu trách nhiệm nếu có sự sai sót từ phía người
              gửi, như: Sai số tài khoản, Nội dung chuyển khoản không đúng.
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { formatPrice } from "~/utils/format";
export default {
  filters: { formatPrice },
  props: {
    order: {
      type: Object,
      default: null,
    },
  },

  methods: {
    copyText(text) {
      navigator.clipboard.writeText(text);
      this.$notify({
        message: "Copied successfully!",
        type: "success",
      });
    },
    onReady() {},
  },
};
</script>
