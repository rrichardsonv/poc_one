class WordCount extends HTMLElement {
  constructor() {
    // Always call super first in constructor
    super();

    // count words in element's parent element
    const wcParent = this.parentNode;

    function countWords(node){
      const text = node.innerText || node.textContent;
      return text.trim().split(/\s+/g).filter(a => a.trim().length > 0).length;
    }

    this.count = countWords(wcParent);
    const shadow = this.attachShadow({mode: 'open'});
    // Append it to the shadow root
    shadow.innerHTML = this.render();
    const rendor = this.render.bind(this);
    // Update count when element content changes
    try {
      setInterval(() => {
        const newCount = countWords(wcParent);
  
        if (newCount !== this.count) {
          this.count = newCount;
          shadow.innerHTML = rendor();
        }
      }, 200);
    } catch (e) {
      ;
    }
  }

  render () {
    return `
    <slot></slot>
    <span style="background:aqua;position:absolute;padding:2px 4px;border-radius:6px;border:1px solid cadetblue;box-shadow: 2px 2px 2px 0 #ccc">Words: ${this.count}</span>
    `;
  }
}

export default function custDef () {
  // Define the new element
  if (window) {
    if (!window?.customElements?.get('word-count')) {
      customElements.define('word-count', WordCount);
    }
  }
}