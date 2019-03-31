import './css/main.css';
import { Main } from './elm/Main.elm';
import registerServiceWorker from './registerServiceWorker';

const app = Main.embed(document.getElementById('root'));

app.ports.save.subscribe((data) => {
  localStorage.setItem(data.key, JSON.stringify(data.model));

  data.model.isShowSaveCompleted = true;
  app.ports.setModel.send(data.model);
});

app.ports.load.subscribe((key) => {
  let data = localStorage.getItem(key);
  let model = JSON.parse(data);

  if (model) {
    model.isShowLoadCompleted = true;
    app.ports.setModel.send(model);
  }
});

registerServiceWorker();
