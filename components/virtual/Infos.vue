<template>
  <div class="pb-20">
    <div class="p-5 bg-white mt-5 grid grid-cols-1 md:grid-cols-2 gap-5">
      <div v-if="virtualTransactions.length > 0">
        <div
          class="relative text-gray-700 bg-white shadow-md w-full rounded-xl bg-clip-border"
        >
          <div
            class="flex min-w-[240px] flex-col gap-1 p-2 font-sans text-base font-normal text-blue-gray-700"
          >
            <span class=""
              ><strong>Tổng tiền nạp: </strong
              >{{ order.amount | formatPrice }} VND</span
            >
            <div
              v-for="(transaction, index) in virtualTransactions"
              :key="index"
              @click="current = index"
              role="button"
              :class="{
                'opacity-50 pointer-events-none': checkTransactions(
                  transaction,
                  index
                ),
                'bg-blue-100': current === index,
              }"
              class="grid grid-cols-5 items-center w-full p-3 leading-tight transition-all rounded-lg outline-none text-start hover:bg-blue-200 focus:bg-blue-gray-50 focus:bg-opacity-80 focus:text-blue-gray-900 active:bg-blue-gray-50 active:bg-opacity-80 active:text-blue-gray-900"
            >
              <span class="col-span-2">Giao dịch số {{ index + 1 }}</span>
              <span class="col-span-2"
                >Số tiền: {{ transaction.amount | formatPrice }} VND</span
              >
              <span class="mx-auto">
                <img
                  v-if="virtualTransactions[index]?.status === 'SUCCEED'"
                  src="~/assets/images/check.svg"
                  class="block h-3"
              /></span>
            </div>
          </div>
        </div>
      </div>
      <div>
        <div class="grid grid-cols-2">
          <div>
            <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
              Ngân hàng:
            </label>
            <div
              class="flex justify-between border-0 border-b border-solid border-[#F2F2F2] pb-1 items-center"
            >
              <div>
                {{ virtualTransactions[current]?.bankName }}
              </div>
            </div>
            <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
              Người nhận:
            </label>
            <div
              class="flex justify-between border-0 border-b border-solid border-[#F2F2F2] pb-1 items-center"
            >
              <div>
                {{ virtualTransactions[current]?.bankAccountName }}
              </div>
              <div
                class="bg-[#F5F8FA] text-[#3554D1] cursor-pointer px-5 py-2 text-xs rounded"
                @click="copyText(virtualTransactions[current]?.bankAccountName)"
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
              <div>{{ virtualTransactions[current]?.bankAccountNo }}</div>
              <div
                class="bg-[#F5F8FA] text-[#3554D1] cursor-pointer px-5 py-2 text-xs rounded"
                @click="copyText(virtualTransactions[current]?.bankAccountNo)"
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
                {{ virtualTransactions[current]?.amount | formatPrice }}
              </div>
              <div
                class="bg-[#F5F8FA] text-[#3554D1] cursor-pointer px-5 py-2 text-xs rounded"
                @click="copyText(virtualTransactions[current]?.amount)"
                variant="outline-primary"
              >
                Sao chép
              </div>
            </div>

            <!-- <label class="text-xs font-medium text-[#7C7C87] mt-5 block">
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
            </div> -->
          </div>
          <img
            v-if="virtualTransactions[current]?.status === 'INITIAL'"
            :src="virtualTransactions[current]?.qrUrl"
            class="w-[300px] mx-auto"
          />
        </div>

        <div v-if="virtualTransactions[current]?.status === 'SUCCEED'">
          <img src="~/assets/images/check.svg" class="w-24 mx-auto block" />
          <div class="text-[#32BEA6] text-2xl font-bold mt-10 mb-2 text-center">
            Giao dịch Thành công
          </div>
        </div>
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
    virtualTransactions: {
      type: Array,
      default: null,
    },
    order: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      current: 0,
    };
  },

  methods: {
    checkTransactions(transaction, index) {
      if (index === 0) return false;
      if (
        this.virtualTransactions[index - 1].status === "SUCCEED" ||
        this.virtualTransactions[index - 1].status === "REVIEW"
      )
        return false;
      return true;
    },
    onReady() {},
    copyText(text) {
      navigator.clipboard.writeText(text);
      this.$notify({
        text: "Copied!",
        type: "success",
      });
    },
  },
};
</script>
<script setup>
import { onMounted } from "vue";
onMounted(() => {});
</script>
