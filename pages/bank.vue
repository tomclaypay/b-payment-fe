<template>
  <div class="home-container" v-if="isReady">
    <div class="bg-white home-container__header">
      <div class="container mx-auto flex items-center h-[70px] px-5 md:px-0">
        <img src="~/assets/images/logo.svg" class="w-20" />
      </div>
    </div>
    <div class="container mx-auto home-container__body">
      <div class="home-container__tabs">
        <div :class="active === 1 && 'active'" class="home-container__tab-1">
          THÔNG TIN CHUYỂN KHOẢN
        </div>
        <div :class="active === 2 && 'active'" class="home-container__tab-2">
          TRẠNG THÁI GIAO DỊCH
        </div>
      </div>

      <home-info :order="order" v-if="active === 1" />
      <home-status :order="order" v-if="active === 2" />
    </div>
  </div>
</template>

<script>
export default {
  auth: false,
  data() {
    return {
      id: null,
      active: 1,
      isReady: false,
      order: null,
      interval: null,
    };
  },
  mounted() {
    this.loadData();
    this.interval = setInterval(() => {
      this.loadData();
    }, 10000);
  },
  methods: {
    async loadData() {
      try {
        const { data } = await this.$axios.post(
          "/bank/deposits/load-order-info",
          {
            data: encodeURIComponent(this.$route.query.order),
          }
        );
        if (data) {
          if (data.status === "CANCELED" || data.status === "SUCCEED") {
            this.active = 2;
            clearInterval(this.interval);
            if (data.redirectUrl) {
              // window.open(data.redirectUrl, "_blank", "noreferrer");
              window.location = data.redirectUrl;
            }
          }

          this.order = data;
        }
        this.isReady = true;
      } catch (e) {
        return this.$nuxt.error({ statusCode: 404 });
      }
    },
  },
};
</script>

<style lang="scss">
.home-container {
  padding-bottom: 40px;
  &__header {
    box-shadow: inset 0px -1px 0px #e2e2ea;
  }

  &__tabs {
    display: flex;
    align-items: center;
    border-radius: 4px;
    width: 100%;
    margin: 10px 0;
    overflow: hidden;

    & > div {
      background: #cad3e1;
      height: 44px;
      width: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      text-transform: uppercase;
      font-weight: 700;
      color: #fff;

      &.active {
        background: #1e427e;
      }
    }
  }

  &__tab-1 {
    position: relative;

    &::before {
      position: absolute;
      top: 0;
      right: -35px;
      bottom: 0;
      width: 50px;
      height: 100%;
      content: "";
      background: url("~/assets/images/tab-arrow-2.png") no-repeat;
      background-size: contain;
    }
    &.active::before {
      background: url("~/assets/images/tab-arrow.png") no-repeat;
      background-size: contain;
    }
  }
}

@media screen and (max-width: 768px) {
  .home-container {
    &__body {
      .container {
        padding: 0;
      }
    }

    &__tabs {
      border-radius: 0;
      margin: 0;

      & > div {
        display: none;
        width: 100%;

        &.active {
          display: flex;
        }
      }
    }
    &__tab-1 {
      &::before {
        content: unset;
      }
    }
  }
}
</style>
