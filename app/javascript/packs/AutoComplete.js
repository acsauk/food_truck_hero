import Search from './Search';

window.onload = () => {
    const target = document.getElementById('search');
    const paramToSearchOn = target.getAttribute("data-param-to-search-on");
    Search.init('search', 'results-list', 'result-item', paramToSearchOn)
  };
