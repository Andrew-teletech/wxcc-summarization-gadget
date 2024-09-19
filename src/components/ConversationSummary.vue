<template>
  <div>
    <p>Summary: {{ summary.textSections.situation }}</p>
    <p>Action: {{ summary.textSections.action }}</p>
  </div>
</template>

<script>

import { library } from '@fortawesome/fontawesome-svg-core';
import { faCheckCircle } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
export default {
  components: {
    FontAwesomeIcon,
  },
  mounted() {
    library.add(faCheckCircle);
  },
  props: {
    summary: Object,
  },
};
</script>

<style scoped>
/* Add any styles for the summary component here */
</style>