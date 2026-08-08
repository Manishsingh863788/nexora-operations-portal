import app from './app';
import { config } from './config';

const PORT = config.port;

app.listen(PORT, () => {
  console.log(`🚀 NEXORA ERP Backend running on port ${PORT} [Env: ${config.nodeEnv}]`);
});
