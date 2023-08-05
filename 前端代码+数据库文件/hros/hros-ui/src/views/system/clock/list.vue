<template>
    <div class="app-container">
      <el-row>
        <el-col>
          您已签到 <span style="color: blue;">{{allDate[0] === "" ? 0 : allDate.length}}</span> 天
        </el-col>
      </el-row>
      <el-calendar :first-day-of-week="7">
          <template slot="dateCell" slot-scope="{ data }" >
              {{ data.day.split("-").slice(2).join("-") }}
              <br>
              <el-button 
                type="text" @click="open(data)"  
                v-if="allDate.indexOf(data.day) === -1 && leaveDate.indexOf(data.day) === -1">签到</el-button>
              <div v-if="allDate.indexOf(data.day) !== -1  " @click="handleDateChange" style="color: green">
                  已签到
              </div>
              <div v-if="leaveDate.indexOf(data.day) !== -1  " @click="handleDateChangeLeave" style="color: orange">
                  请假
              </div>
          </template>
      </el-calendar>
    </div>
</template>
<style>
.is-selected {
  color: #1989FA;
}
</style>
<script>
import api from '@/api/system/user'
export default {
  data() {
    return {
        // workDate:{
        //     date:""
        // },
        selectedDate: new Date(), // 当前选中日期
        allDate: [], // 签到日期列表
        leaveDate: [], // 请假日期列表
        // calendarData:[ 
        //     { day: "2023-03-15",status:"pass", },
        //     { day: "2021-04-06",status:"unpass", },
        // ]
    };
  },
  mounted() {
    this.init();
  },
  methods: {
    isDateGreaterThanToday(date) {
      const today = new Date();
      const select = new Date(date.day);
      if (today.getFullYear() !== select.getFullYear()) {
        return false;
      } else if (today.getMonth() !== select.getMonth()) {
        return false;
      } else if (today.getDate() !== select.getDate()) {
        return false;
      }
      return true;
    },
    handleDateChange(date) {
      this.$notify.success({
        title: '签到',
        message: '已经签过到了',
        showClose: false,
        offset: 100,
        duration: 1500,
        customClass: 'fontclass'
      });
    },
    handleDateChangeLeave(date) {
      this.$notify.warning({
        title: '签到',
        message: '您今日已请假，请联系管理员撤销',
        showClose: false,
        offset: 100,
        duration: 1500,
        customClass: 'fontclass'
      });
    },
    init(){
      api.selectWorkDate().then(response => {
        if (response) {
          this.allDate = [];
          for (var i = 0; i < response.data.length; i++) {
              this.allDate.push(response.data[i]);
          }
        }
      });
      api.selectLeaveDate().then(response => {
        if (response) {
          this.LeaveDate = [];
          for (var i = 0; i < response.data.length; i++) {
              this.leaveDate.push(response.data[i]);
          }
        }
      });
    },
    open(data) {
      if (!this.isDateGreaterThanToday(data)){
        this.$notify.error({
          title: '签到',
          message: '现在不是签到时间',
          showClose: false,
          offset: 100,
          duration: 1500,
          customClass: 'fontclass'
        });
        return;
      }
      this.$confirm('是否签到?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        api.workDate(data.day).then(response => {
            if (response) {
                this.init();
            }
        });
        this.$notify.success({
          title: '签到',
          message: '签到成功',
          showClose: false,
          offset: 100,
          duration: 1500,
          customClass: 'fontclass'
        });
      }).catch(() => {
        this.$notify.warning({
          title: '签到',
          message: '已取消签到',
          showClose: false,
          offset: 100,
          duration: 1500,
          customClass: 'fontclass'
        });
      });
    }
  },
};
</script>