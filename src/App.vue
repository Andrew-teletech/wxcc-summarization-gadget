<template>
  <div>
    <button @click="getSummary" v-if="!summary">Get Conversation Summary</button>
    <ConversationSummary v-if="summary" :summary="summary" />
  </div>
</template>

<script>
import axios from 'axios'; // Install axios: npm install axios
import ConversationSummary from '@/components/ConversationSummary.vue'; // (optional)

export default {
  name: 'App',
  components: {
    ConversationSummary, // (optional)
  },
  data() {
    return {
      summary: null,
      token: null,
    };
  },
  mounted() {
    this.fetchToken();
  },
  methods: {
    async getSummary() {
      console.log("GetSummary")
      if (!this.token) {
        await this.fetchToken();
      }

      const projectId = 'digital-is-ops-sandbox-01'; // Replace with your project ID
      const locationId = 'global'; // Replace with your location ID

      const url = `https://ui-connector-r673rdpkqq-uc.a.run.app/v2/projects/${projectId}/locations/${locationId}/conversations/103vYMR6e1TTYSQtaipLZeDig/suggestions:suggestConversationSummary`;

      try {
        const response = await axios.post(url, { contextSize: 1000 }, {
          headers: {
            'Authorization': this.token,
          },
        });
        this.summary = response.data.summary;
      } catch (error) {
        console.error('Error fetching summary:', error);
      }
    },
    async fetchToken() {
      console.log("fetchToken")
      const tokenUrl = 'https://ui-connector-r673rdpkqq-uc.a.run.app/register';
      const body = { gcp_agent_assist_user: '', type: 'skip' };

      try {
        const response = await axios.post(tokenUrl, body);
        this.token = response.data.token; // Assuming the token is directly in the response data
        // Call getSummary immediately after successful token retrieval
        console.log("We got a token, lets try pageload getSummary")
        await this.getSummary();
      } catch (error) {
        console.error('Error fetching token:', error);
      }
    },
  },
};
</script>

<style scoped>
/* Add any styles for your application here */
</style>