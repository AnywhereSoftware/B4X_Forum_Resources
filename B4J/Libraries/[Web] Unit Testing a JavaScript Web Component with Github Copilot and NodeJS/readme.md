### [Web] Unit Testing a JavaScript Web Component with Github Copilot and NodeJS by Mashiane
### 05/13/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166979/)

Hi Fam  
  
[Source Code](https://github.com/Mashiane/DaisyUI-TreeView)  
  
Well I have been creating a treeview component for DaisyUI from scratch using Github Copilot. So far this is the final code. This component did not exist and I need it so why not.  
  

```B4X
const DEFAULTS = {  
  data: [],  
  expandIconUrl: "./assets/chevron-down-solid.svg",  
  collapseIconUrl: "./assets/chevron-right-solid.svg",  
  blankIconUrl: "./assets/blank.svg",  
  hasCheckbox: false,  
  treeName: "treeView", // Changed to camelCase  
  multipleSelect: false,  
  multipleCheck: false,  
  iconHeight: "16px",  
  iconWidth: "16px",  
  inlineEdit: false,  
  dragNDrop: false,  
  itemColor: 'primary',  
  itemActiveColor: '',  
  itemFocusColor: '',  
  itemHoverColor: '',  
  UseLocalstorage: true,  
  replace: false,  
  checkBoxSize: "md",  
  textBoxSize: "sm",  
  checkBoxActiveColor: "",  
  checkBoxActiveBorderColor: "",  
};  
/**  
 * DaisyUITreeView is a customizable tree view component that supports features like  
 * drag-and-drop, inline editing, multi-selection, and dynamic node management.  
 * It allows developers to create interactive and accessible tree structures.  
 */  
class DaisyUITreeView {  
  /**  
   * Creates an instance of DaisyUITreeView.  
   * @param {HTMLElement} container - The container element where the tree view will be rendered.  
   * @param {Object} [options={}] - Configuration options for the tree view.  
   * @param {Array} [options.data=[]] - Initial data for the tree structure.  
   * @param {string} [options.expandIconUrl] - URL for the expand icon.  
   * @param {string} [options.collapseIconUrl] - URL for the collapse icon.  
   * @param {boolean} [options.hasCheckbox=false] - Whether nodes should have checkboxes.  
   * @param {string} [options.treeName="treeView"] - Unique name for the tree view.  
   * @param {boolean} [options.multipleSelect=false] - Whether multiple nodes can be selected.  
   * @param {boolean} [options.multipleCheck=false] - Whether multiple nodes can be checked.  
   * @param {string} [options.iconHeight="16px"] - Height of the icons.  
   * @param {string} [options.iconWidth="16px"] - Width of the icons.  
   * @param {boolean} [options.inlineEdit=false] - Whether inline editing is enabled.  
   * @param {boolean} [options.dragNDrop=false] - Whether drag-and-drop is enabled.  
   * @param {string} [options.itemColor=""] - CSS class for item color.  
   * @param {string} [options.itemActiveColor=""] - CSS class for active item color.  
   * @param {string} [options.itemFocusColor=""] - CSS class for focused item color.  
   * @param {string} [options.itemHoverColor=""] - CSS class for hover item color.  
   */  
  constructor(container, options = {}) {  
    this.element = container;  
    this.settings = { …DEFAULTS, …options };  
    this.treeName = this._normalizeId(this.settings.treeName);  
    this.tree = [];  
    this.nodeMap = new Map();  
    this._checkedNodes = new Set();  
    this._selectedNodes = new Set();  
    this._visibleNodes = new Set();  
    this._activeColor = this.fixColor('checked:bg', this.settings.checkBoxActiveColor);  
    this._activeBorderColor = this.fixColor('checked:border', this.settings.checkBoxActiveBorderColor);  
    this._inputColorClass = `input-${this.settings.itemColor}`;  
    this._checkColorClass = `checkbox-${this.settings.itemColor}`;  
    this._inputSizeClass = `input-${this.settings.textBoxSize}`;  
    this._checkSizeClass = `checkbox-${this.settings.checkBoxSize}`;  
    if (this.settings.data) {  
      let data = Array.isArray(this.settings.data)  
        ? JSON.parse(JSON.stringify(this.settings.data))  
        : [];  
      this.tree = data;  
      delete this.settings.data;  
    }  
    this._refresh();  
    if (this.settings.dragNDrop) this._enableDragAndDrop();  
    this.element.addEventListener("blur", this._onBlur.bind(this), true);  
    this.element.addEventListener("keydown", this._onKeydown.bind(this));  
    this.element.addEventListener("click", (e) => this._onClick(e));  
    const style = document.createElement('style');  
    style.innerHTML = `.xsummary::after { display: none !important; }`;  
    document.head.appendChild(style);  
  }  
  _toggleVisibility(element, show) {  
    if (!element) return;  
    if (show) {  
      element.classList.remove("hidden");  
    } else {  
      element.classList.add("hidden");  
    }  
  }  
  _getElementById(id) {  
    return document.getElementById(id);  
  }  
  _onCheckboxChange(nodeId, checked) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    // Update the checked state of the node  
    this.checkNode(nodeId, checked);  
    // Dispatch a custom event to notify about the checkbox change  
    this._dispatchEvent("nodeChecked", { node, checked });  
  }  
fixColor(prefix, suffix) {  
    // Treat null or undefined as blank  
    prefix = prefix == null ? '' : String(prefix);  
    suffix = suffix == null ? '' : String(suffix);  
    if (!prefix || !suffix) {  
        return '';  
    }  
    if (suffix.startsWith('#')) {  
        suffix = `[${suffix}]`;  
    }  
    if (prefix === 'btn' || prefix === 'badge') {  
        prefix = 'bg';  
    }  
    const result = `${prefix}-${suffix}`;  
    if (result.endsWith('-')) {  
        return '';  
    }  
    return result;  
  }  
   /**  
   * Collapses all nodes in the tree view.  
   */  
  collapseAll() {  
    const collapseRecursive = (nodes) => {  
      for (const node of nodes) {  
        this._collapseNode(node.nodeId);  
        if (node.nodes) collapseRecursive(node.nodes);  
      }  
    };  
    collapseRecursive(this.tree);  
  }  
    /**  
   * Expands all nodes in the tree view.  
   */  
  expandAll() {  
    const expandRecursive = (nodes) => {  
      for (const node of nodes) {  
        this._expandNode(node.nodeId);  
        if (node.nodes) expandRecursive(node.nodes); // Recursively expand child nodes  
      }  
    };  
    expandRecursive(this.tree);  
  }  
  _refresh() {  
    const fragment = document.createDocumentFragment();  
    this._initializeData({ nodes: this.tree });  
    this._build(fragment, this.tree);  
    this.element.innerHTML = ""; // Clear only once  
    this.element.appendChild(fragment);  
  }  
  _initializeData(context) {  
    if (!context.nodes) return;  
    for (const node of context.nodes) {  
      node.nodeId = this._normalizeId(node.nodeId);  
      node.parentId = this._normalizeId(node.parentId);  
      this._visibleNodes.add(node.nodeId);  
      this.nodeMap.set(node.nodeId, node);  
      if (node.nodes) this._initializeData({ nodes: node.nodes });  
    }  
  }  
  _build(container, nodeList) {  
    for (const node of nodeList) {  
      const item = document.createElement("li");  
      item.id = `${this.treeName}-${node.nodeId}`;  
      item.classList.add("list-item");  
      item.dataset.id = node.nodeId;  
      item.setAttribute("role", "treeitem");  
      item.setAttribute("aria-expanded", node.expanded || false);  
      if (this.settings.dragNDrop) item.setAttribute("draggable", "true");  
      item.setAttribute(  
        "aria-selected",  
        this._selectedNodes.has(node.nodeId) || false  
      );  
      if (this.settings.itemColor !== '') item.classList.add(this.settings.itemColor);  
      if (this.settings.itemActiveColor !== '') item.classList.add(this.settings.itemActiveColor);  
      if (this.settings.itemFocusColor !== '') item.classList.add(this.settings.itemFocusColor);  
      if (this.settings.itemHoverColor !== '') item.classList.add(this.settings.itemHoverColor);  
      if (!this._visibleNodes.has(node.nodeId)) {  
        this._toggleVisibility(item, false);  
      }  
      if (this._selectedNodes.has(node.nodeId)) {  
        item.classList.add("menu-active");  
      }  
      if (node.disabled) {  
        item.setAttribute("aria-disabled", "true");  
        item.classList.add("menu-disabled");  
      }  
            
      if (node.nodes && node.nodes.length > 0) {  
        const details = document.createElement("details");  
        details.id = `${this.treeName}-${node.nodeId}-details`;  
        details.dataset.id = node.nodeId;  
        details.classList.add("xdetails");  
        item.classList.add("xdetails");  
        if (node.expanded) details.setAttribute("open", "");  
        const summary = document.createElement("summary");  
        summary.id = `${this.treeName}-${node.nodeId}-summary`;  
        summary.dataset.id = node.nodeId;  
        summary.classList.add("xsummary");       
         
        const hostdiv = document.createElement("div");  
        hostdiv.id = `${this.treeName}-${node.nodeId}-div`;  
        hostdiv.classList.add("flex", "items-center", "gap-3", "w-full", "xdiv");  
         
        if (node.iconUrl === "") node.iconUrl = this.settings.collapseIconUrl;  
        if (node.iconUrl) {  
          const icon = document.createElement("svg-renderer");  
          icon.setAttribute("replace", this.settings.replace);  
          icon.id = `${this.treeName}-${node.nodeId}-icon`;  
          icon.dataset.id = node.nodeId;  
          icon.setAttribute("use-localstorage", this.settings.UseLocalstorage);  
          icon.dataset.src = node.expanded  
            ? this.settings.expandIconUrl  
            : this.settings.collapseIconUrl;  
          icon.classList.add("state-icon", "xicon");  
          icon.setAttribute("style", "pointer-events:none; min-height:" + this.settings.iconHeight + "; min-width:" + this.settings.iconWidth + ";"); // Updated  
          icon.setAttribute("fill", "currentColor"); // Updated  
          icon.setAttribute("data-js", "enabled"); // Updated  
          icon.setAttribute("width", this.settings.iconWidth);  
          icon.setAttribute("height", this.settings.iconHeight);  
          hostdiv.appendChild(icon);  
        }  
        if (this.settings.hasCheckbox) {  
          const checkbox = document.createElement("input");  
          checkbox.id = `${this.treeName}-${node.nodeId}-check`;  
          checkbox.type = "checkbox";  
          checkbox.classList.add("checkbox");  
          if (this._checkColorClass !== '') checkbox.classList.add(this._checkColorClass);  
          if (this._activeColor !== '') checkbox.classList.add(this._activeColor);  
          if (this._activeBorderColor !== '') checkbox.classList.add(this._activeBorderColor);  
          if (this._checkSizeClass !== '') checkbox.classList.add(this._checkSizeClass);  
          checkbox.dataset.id = node.nodeId;  
          checkbox.checked = this._checkedNodes.has(node.nodeId);  
          hostdiv.appendChild(checkbox);  
        }  
        const txtBox = document.createElement("input");  
        txtBox.id = `${this.treeName}-${node.nodeId}-input`;  
        txtBox.type = "text";  
        txtBox.value = node.text;  
        txtBox.classList.add(  
          "input",  
          "input-ghost",  
          "hidden",  
          "xinput",  
          "w-full"  
        );  
        if (this._inputColorClass !== '') txtBox.classList.add(this._inputColorClass);    
        if (this._inputSizeClass !== '') txtBox.classList.add(this._inputSizeClass);        
        txtBox.dataset.id = node.nodeId;  
        hostdiv.appendChild(txtBox);  
        const textNode = document.createElement("span");  
        textNode.id = `${this.treeName}-${node.nodeId}-text`;  
        textNode.textContent = node.text;  
        textNode.dataset.id = node.nodeId;  
        textNode.classList.add("xspan");  
        hostdiv.appendChild(textNode);  
        summary.appendChild(hostdiv);  
        details.appendChild(summary);  
        const nestedList = document.createElement("ul");  
        nestedList.id = `${this.treeName}-${node.nodeId}-ul`;  
        nestedList.dataset.id = node.nodeId;  
        this._build(nestedList, node.nodes);  
        details.appendChild(nestedList);  
        item.appendChild(details);  
      } else {  
        // div class="flex items-center gap-3 w-full"  
        const link = document.createElement("div");  
        link.id = `${this.treeName}-${node.nodeId}-anchor`;  
        link.dataset.id = node.nodeId;  
        link.classList.add("xanchor", "flex", "items-center", "gap-3", "w-full");  
        if (this.settings.itemColor !== '') link.classList.add(this.settings.itemColor);  
        if (this.settings.itemActiveColor !== '') link.classList.add(this.settings.itemActiveColor);  
        if (this.settings.itemFocusColor !== '') link.classList.add(this.settings.itemFocusColor);  
        if (this.settings.itemHoverColor !== '') link.classList.add(this.settings.itemHoverColor);  
        if (node.href) {  
          link.setAttribute("href", node.href);  
        }  
        if (node.iconUrl === "") node.iconUrl = this.settings.blankIconUrl;  
        if (node.iconUrl) {  
          const icon = document.createElement("svg-renderer");  
          icon.setAttribute("replace", this.settings.replace);  
          icon.setAttribute("use-localstorage", this.settings.UseLocalstorage);  
          icon.dataset.id = node.nodeId;  
          icon.dataset.src = node.iconUrl;  
          icon.id = `${this.treeName}-${node.nodeId}-icon`;  
          icon.classList.add("state-icon");  
          icon.setAttribute("style", "pointer-events:none; min-height:" + this.settings.iconHeight + "; min-width:" + this.settings.iconWidth + ";"); // Updated  
          icon.setAttribute("fill", "currentColor"); // Updated  
          icon.setAttribute("data-js", "enabled"); // Updated  
          icon.setAttribute("width", this.settings.iconWidth);  
          icon.setAttribute("height", this.settings.iconHeight);  
          link.appendChild(icon);  
        }  
        if (this.settings.hasCheckbox) {  
          const checkbox = document.createElement("input");  
          checkbox.id = `${this.treeName}-${node.nodeId}-check`;  
          checkbox.type = "checkbox";  
          checkbox.classList.add("checkbox");  
          checkbox.dataset.id = node.nodeId;  
          checkbox.checked = this._checkedNodes.has(node.nodeId);  
          if (this._checkColorClass !== '') checkbox.classList.add(this._checkColorClass);  
          if (this._activeColor !== '') checkbox.classList.add(this._activeColor);  
          if (this._activeBorderColor !== '') checkbox.classList.add(this._activeBorderColor);  
          if (this._checkSizeClass !== '') checkbox.classList.add(this._checkSizeClass);  
          link.appendChild(checkbox);  
        }  
        const txtBox = document.createElement("input");  
        txtBox.id = `${this.treeName}-${node.nodeId}-input`;  
        txtBox.type = "text";  
        txtBox.value = node.text;  
        txtBox.classList.add(  
          "input",  
          "input-ghost",  
          "hidden",  
          "w-full",  
          "xinput"  
        );  
        if (this._inputColorClass !== '') txtBox.classList.add(this._inputColorClass);    
        if (this._inputSizeClass !== '') txtBox.classList.add(this._inputSizeClass);  
        txtBox.dataset.id = node.nodeId;  
        link.appendChild(txtBox);  
        const textNode = document.createElement("span");  
        textNode.id = `${this.treeName}-${node.nodeId}-text`;  
        textNode.textContent = node.text;  
        textNode.dataset.id = node.nodeId;  
        textNode.classList.add("xspan");  
        link.appendChild(textNode);  
        item.appendChild(link);  
      }  
      container.appendChild(item);  
    }  
  }  
  _onClick(e) {  
    // if we checked a checkbox, then exit  
    const checkbox = e.target.closest(".checkbox");  
    if (checkbox) {  
      e.stopPropagation(); // Prevent further propagation  
      const nodeId = this._normalizeId(checkbox.dataset.id);  
      if (this.nodeExists(nodeId)) {  
        const checked = checkbox.checked;  
        this._onCheckboxChange(nodeId, checked); // Handle checkbox logic  
      }  
      return; // Exit to prevent firing other events  
    }  
    const xsummary = e.target.closest(".xsummary");  
    if (xsummary) {  
      e.stopPropagation(); // Prevent further propagation  
      const id = this._normalizeId(xsummary.dataset.id);  
      if (!this.nodeExists(id)) return;  
      const node = this.findNode(id);  
      const details = this._getElementById(`${this.treeName}-${id}-details`);  
      let show = details.hasAttribute("open");  
      show = !show;  
      node.expanded = show;  
      const evt = show ? "nodeExpanded" : "nodeCollapsed";  
      const icon = this._getElementById(`${this.treeName}-${id}-icon`);  
      if (icon) {  
        if (show) {  
          icon.setAttribute("data-src", this.settings.expandIconUrl);  
        } else {  
          icon.setAttribute("data-src", this.settings.collapseIconUrl);  
        }  
        node.iconUrl = icon.getAttribute("data-src");  
      }  
      this._dispatchEvent(evt, { node });  
      return;  
    }  
    const xspan = e.target.closest(".xspan");  
    if (xspan) {  
      e.stopPropagation(); // Prevent further propagation  
      const id = this._normalizeId(xspan.dataset.id);  
      if (!this.nodeExists(id)) return;  
      const node = this.findNode(id);  
      if (  
        this.settings.inlineEdit &&  
        e.target.id === `${this.treeName}-${id}-text`  
      ) {  
        this._enableInlineEdit(id); // Activate inline editing  
        return; // Exit to prevent firing nodeClick  
      }  
      // Fire nodeClick event  
      this._dispatchEvent("nodeClick", { node });  
      return;  
    }  
    const xanchor = e.target.closest(".xanchor");  
    if (xanchor) {  
      e.stopPropagation(); // Prevent further propagation  
      const id = this._normalizeId(xanchor.dataset.id);  
      if (!this.nodeExists(id)) return;  
      const node = this.findNode(id);  
      if (this.settings.inlineEdit) {  
        this._enableInlineEdit(id); // Activate inline editing  
        return; // Exit to prevent firing nodeClick  
      }  
      // Fire nodeClick event  
      this._dispatchEvent("nodeClick", { node });  
      return;  
    }  
  }  
  _enableDragAndDrop() {  
    this.element.addEventListener("dragend", (e) => {  
      const item = this.element.querySelector(".drag-over");  
      if (item) item.classList.remove("drag-over");  
    });  
    this.element.addEventListener("dragstart", (e) => {  
      const item = e.target.closest(".list-item");  
      if (item) e.dataTransfer.setData("id", item.dataset.id);  
    });  
    this.element.addEventListener("dragover", (e) => {  
      e.preventDefault();  
      const item = e.target.closest(".list-item");  
      if (item) item.classList.add("drag-over");  
    });  
    this.element.addEventListener("dragleave", (e) => {  
      const item = e.target.closest(".list-item");  
      if (item) item.classList.remove("drag-over");  
    });  
    this.element.addEventListener("drop", (e) => {  
      e.preventDefault();  
      const targetItem = e.target.closest(".list-item");  
      if (!targetItem) return;  
      const draggedNodeId = e.dataTransfer.getData("id");  
      const targetNodeId = targetItem.dataset.id;  
      if (draggedNodeId === targetNodeId) return; // Prevent dropping onto itself  
      const draggedNode = this.findNode(draggedNodeId);  
      const targetNode = this.findNode(targetNodeId);  
      let parent = targetNode;  
      while (parent) {  
        if (parent.nodeId === draggedNodeId) return; // Prevent dropping onto descendants  
        parent = this.findNode(parent.parentId);  
      }  
      if (draggedNode && targetNode) {  
        // Enhancement: Dispatch custom events for drag-and-drop actions  
        this._dispatchEvent("nodeDragStart", { draggedNode });  
        this._dispatchEvent("nodeDrop", { draggedNode, targetNode });  
        this.removeNode(draggedNodeId);  
        this.addNode(  
          targetNodeId,  
          draggedNode.nodeId,  
          draggedNode.iconUrl,  
          draggedNode.text,  
          draggedNode.href,  
          draggedNode.hasCheckbox  
        );  
        this._refresh();  
      }  
    });  
  }  
  _normalizeId(id) {  
    return (id ?? "").toString().trim().toLowerCase();  
  }  
  _cstr(id) {  
    return (id ?? "").toString();  
  }  
  nodeExists(nodeId) {  
    const normalizedId = this._normalizeId(nodeId);  
    if (normalizedId === "") return false;  
    return this.nodeMap.has(normalizedId);  
  }  
  findNode(nodeId) {  
    const normalizedId = this._normalizeId(nodeId);  
    if (normalizedId === "") return null; // Return null if the normalized ID is empty  
    return this.nodeMap.get(normalizedId) || null; // Return the node or null if not found  
  }  
    /**  
   * Adds a new node to the tree.  
   * @param {string} parentId - The ID of the parent node.  
   * @param {string} nodeId - The ID of the new node.  
   * @param {string} [iconUrl=""] - URL for the node's icon.  
   * @param {string} text - The text content of the node.  
   * @param {string} [href=""] - The hyperlink for the node.  
   */  
  addNode(parentId, nodeId, iconUrl = "", text, href = "") {  
    parentId = this._normalizeId(parentId);  
    nodeId = this._normalizeId(nodeId);  
    iconUrl = this._cstr(iconUrl);  
    text = this._cstr(text);  
    href = this._cstr(href);  
    //  
    if (nodeId === "") return;  
    if (this.nodeExists(nodeId)) return;  
   
    const hasCheckbox = this.settings.hasCheckbox || false;  
    const newNode = { nodeId, parentId, iconUrl, text, href, hasCheckbox };  
    if (parentId === "") {  
      this.tree.push(newNode);  
    } else {  
      const parent = this.findNode(parentId);  
      if (parent) {  
        parent.nodes = parent.nodes || [];  
        parent.nodes.push(newNode);  
        this.nodeMap.set(parentId, parent);  
      }  
    }  
    this.nodeMap.set(nodeId, newNode); // Add to node map  
    this._visibleNodes.add(nodeId);  
  }  
  findNodeRecursive(tree, nodeId) {  
    for (const node of tree) {  
      if (node.nodeId === nodeId) {  
        return node; // Node found  
      }  
      if (node.nodes && node.nodes.length > 0) {  
        const result = findNodeRecursive(node.nodes, nodeId); // Recursively search in child nodes  
        if (result) {  
          return result; // Return the node if found in children  
        }  
      }  
    }  
    return null; // Node not found  
  }  
    /**  
   * Hides a node and its children from the tree view.  
   * @param {string} nodeId - The ID of the node to hide.  
   */  
  hideNode(nodeId) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    const hideChildren = (node) => {  
      if (!node) return;  
      this._visibleNodes.delete(node.nodeId);  
      node.visible = false;  
      const item = this._getElementById(`${this.treeName}-${node.nodeId}`);  
      if (item) this._toggleVisibility(item, false);  
      if (node.nodes) {  
        node.nodes.forEach((child) => hideChildren(child));  
      }  
    };  
    hideChildren(node);  
  }  
    /**  
   * Shows a previously hidden node and its children.  
   * @param {string} nodeId - The ID of the node to show.  
   */  
  showNode(nodeId) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    const showChildren = (node) => {  
      if (!node) return;  
      this._visibleNodes.add(node.nodeId);  
      node.visible = true;  
      const item = this._getElementById(`${this.treeName}-${node.nodeId}`);  
      if (item) this._toggleVisibility(item, true);  
      if (node.nodes) {  
        node.nodes.forEach((child) => showChildren(child));  
      }  
    };  
    showChildren(node);  
  }  
    /**  
   * Checks or unchecks a node and its children.  
   * @param {string} nodeId - The ID of the node to check or uncheck.  
   * @param {boolean} state - The checked state (true for checked, false for unchecked).  
   */  
  checkNode(nodeId, state) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    const checkChildren = (node, state) => {  
      if (!node) return;  
      if (state) {  
        this._checkedNodes.add(node.nodeId);  
      } else {  
        this._checkedNodes.delete(node.nodeId);  
      }  
      node.checked = state;  
      const check = this._getElementById(  
        `${this.treeName}-${node.nodeId}-check`  
      );  
      if (check) check.checked = state;  
      if (node.nodes) {  
        node.nodes.forEach((child) => checkChildren(child, state));  
      }  
    };  
    checkChildren(node, state);  
  }  
  /**  
 * Expands or collapses a specific node in the tree view.  
 * @param {string} nodeId - The ID of the node to expand or collapse.  
 * @param {boolean} state - The expanded state (true for expanded, false for collapsed).  
 */  
  expandNode(nodeId, state) {  
    if (state) this._expandNode(nodeId);  
    else this._collapseNode(nodeId);  
  }  
    /**  
   * Removes a node from the tree.  
   * @param {string} nodeId - The ID of the node to remove.  
   */  
  removeNode(nodeId) {  
    nodeId = this._normalizeId(nodeId);  
    if (!this.nodeExists(nodeId)) return;  
   
    const node = this.findNode(nodeId);  
   
    // Remove the node from its parent's nodes array  
    if (node.parentId) {  
      const parent = this.findNode(node.parentId);  
      if (parent && parent.nodes) {  
        parent.nodes = parent.nodes.filter((child) => child.nodeId !== nodeId);  
      }  
    } else {  
      // If the node has no parent, it's a root node, so remove it from the tree  
      this.tree = this.tree.filter((rootNode) => rootNode.nodeId !== nodeId);  
    }  
   
    // Remove the node from the nodeMap  
    this.nodeMap.delete(nodeId);  
   
    // Remove the node from the DOM  
    const item = this._getElementById(`${this.treeName}-${nodeId}`);  
    if (item) item.remove();  
   
    // Remove the node from the visible and selected sets  
    this._visibleNodes.delete(nodeId);  
    this._selectedNodes.delete(nodeId);  
    this._checkedNodes.delete(nodeId);  
  }  
  _expandNode(nodeId) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    node.expanded = true;  
    const details = this._getElementById(  
      `${this.treeName}-${node.nodeId}-details`  
    );  
    if (details) details.setAttribute("open", "");  
  }  
  _collapseNode(nodeId) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    node.expanded = false;  
    const details = this._getElementById(  
      `${this.treeName}-${node.nodeId}-details`  
    );  
    if (details) details.removeAttribute("open");  
  }  
  /**  
 * Enables or disables a specific node and its children.  
 * @param {string} nodeId - The ID of the node to enable or disable.  
 * @param {boolean} state - The enabled state (true for enabled, false for disabled).  
 */  
  enableNode(nodeId, state) {  
    if (state) this._enableNode(nodeId);  
    else this._disableNode(nodeId);  
  }  
  _enableNode(nodeId) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    const enableChildren = (node) => {  
      if (!node) return;  
      node.disabled = false;  
      const item = this._getElementById(`${this.treeName}-${node.nodeId}`);  
      if (item) item.classList.remove("menu-disabled");  
      if (node.nodes) {  
        node.nodes.forEach((child) => enableChildren(child));  
      }  
    };  
    enableChildren(node);  
  }  
  _disableNode(nodeId) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    const disableChildren = (node) => {  
      if (!node) return;  
      node.disabled = true;  
      const item = this._getElementById(`${this.treeName}-${node.nodeId}`);  
      if (item) item.classList.add("menu-disabled");  
      if (node.nodes) {  
        node.nodes.forEach((child) => disableChildren(child));  
      }  
    };  
    disableChildren(node);  
  }  
    /**  
   * Clears all nodes and resets the tree view.  
   */  
  clear() {  
    this.nodeMap.clear();  
    this.tree = [];  
    this._checkedNodes.clear();  
    this._selectedNodes.clear(); // Clear all selected nodes  
    this._visibleNodes.clear();  
  }  
    /**  
   * Retrieves the children of a specific node.  
   * @param {string} nodeId - The ID of the node to retrieve children for.  
   * @returns {Array} An array of child nodes.  
   */  
  getChildren(nodeId) {  
    if (!this.nodeExists(nodeId)) return [];  
    const node = this.findNode(nodeId);  
    return Array.isArray(node.nodes) ? […node.nodes] : [];  
  }  
    /**  
   * Removes all children of a specific node.  
   * @param {string} nodeId - The ID of the node to remove children from.  
   */  
  removeChildren(nodeId) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    if (node.nodes) {  
      node.nodes.forEach((child) => this._checkedNodes.delete(child.nodeId));  
      node.nodes.forEach((child) => this._selectedNodes.delete(child.nodeId));  
      node.nodes.forEach((child) => this._visibleNodes.delete(child.nodeId));  
      node.nodes.forEach((child) => this.removeNode(child.nodeId));  
    }  
    node.nodes = [];  
  }  
    /**  
   * Updates the properties of a node.  
   * @param {string} nodeId - The ID of the node to update.  
   * @param {string} iconUrl - The new icon URL for the node.  
   * @param {string} text - The new text content for the node.  
   * @param {string} [href=""] - The new hyperlink for the node.  
   */  
  updateNode(nodeId, iconUrl, text, href = "") {  
    nodeId = this._normalizeId(nodeId);  
    iconUrl = this._cstr(iconUrl);  
    text = this._cstr(text);  
    href = this._cstr(href);  
    if (nodeId === "") return;  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    node.iconUrl = iconUrl;  
    node.text = text;  
    node.href = href;  
    //  
    const txt = this._getElementById(`${this.treeName}-${node.nodeId}-text`);  
    if (txt) txt.textContent = text;  
    const inp = this._getElementById(`${this.treeName}-${node.nodeId}-input`);  
    if (inp) inp.value = text;  
    const icon = this._getElementById(`${this.treeName}-${node.nodeId}-icon`);  
    if (icon) icon.dataset.src = iconUrl;  
  }  
    /**  
   * Selects or deselects a node and its children.  
   * @param {string} nodeId - The ID of the node to select or deselect.  
   * @param {boolean} state - The selected state (true for selected, false for deselected).  
   */  
  selectNode(nodeId, state) {  
    if (!this.nodeExists(nodeId)) return;  
    const node = this.findNode(nodeId);  
    const selectChildren = (node, state) => {  
      if (!node) return;  
      if (state) {  
        this._selectedNodes.add(node.nodeId);  
      } else {  
        this._selectedNodes.delete(node.nodeId);  
      }  
      node.selected = state;  
      const item = this._getElementById(`${this.treeName}-${node.nodeId}`);  
      if (item) {  
        if (state) item.classList.add("menu-active");  
        else item.classList.remove("menu-active");  
      }  
      if (node.nodes) {  
        node.nodes.forEach((child) => selectChildren(child, state));  
      }  
    };  
    selectChildren(node, state);  
  }  
    /**  
   * Clears all selected nodes in the tree view.  
   */  
  clearSelected() {  
    this._selectedNodes.forEach((child) =>  
      this.selectNode(child.nodeId, false)  
    );  
    this._selectedNodes.clear(); // Clear all selected nodes  
  }  
    /**  
   * Clears all checked nodes in the tree view.  
   */  
  clearChecked() {  
    this._checkedNodes.forEach((child) => this.checkNode(child.nodeId, false));  
    this._checkedNodes.clear(); // Clear all checked nodes  
  }  
    /**  
   * Selects multiple nodes in the tree view.  
   * @param {Array<string>} nodeIds - An array of node IDs to select.  
   */  
  selectNodes(nodeIds) {  
    this._selectedNodes.forEach((child) =>  
      this.selectNode(child.nodeId, false)  
    );  
    const normalizedIds = new Set(nodeIds.map((id) => this._normalizeId(id)));  
    normalizedIds.forEach((child) => this.selectNode(child, true));  
    //this._dispatchEvent('nodesSelected', { nodeIds: normalizedIds });  
  }  
    /**  
   * Retrieves the currently selected node.  
   * @param {boolean} [includeChildren=false] - Whether to include child nodes in the result.  
   * @returns {Object|null} The selected node or null if no node is selected.  
   */  
  getSelectedNode(includeChildren = false) {  
    const el = this.element.querySelector(".menu-active");  
    if (!el) return null;  
    const nodeId = this._normalizeId(el.dataset.id);  
    const node = this.findNode(nodeId);  
    if (!node || !includeChildren) return node;  
    return { …node, nodes: node.nodes ?? [] };  
  }  
    /**  
   * Retrieves all selected nodes in the tree view.  
   * @returns {Array} An array of selected node IDs.  
   */  
  getSelectedNodes() {  
    // Return all selected nodes  
    return Array.from(this._selectedNodes);  
  }  
    /**  
   * Retrieves all checked nodes in the tree view.  
   * @returns {Array} An array of checked node IDs.  
   */  
  getCheckedNodes() {  
    return Array.from(this._checkedNodes);  
  }  
    /**  
   * Checks multiple nodes in the tree view.  
   * @param {Array<string>} nodeIds - An array of node IDs to check.  
   */  
  checkNodes(nodeIds) {  
    this._checkedNodes.forEach((child) => this.checkNode(child.nodeId, false));  
    const normalizedIds = new Set(nodeIds.map((id) => this._normalizeId(id)));  
    normalizedIds.forEach((child) => this.checkNode(child, true));  
    this._dispatchEvent("nodesChecked", { nodeIds: normalizedIds });  
  }  
    /**  
   * Enables inline editing for a specific node.  
   * @param {string} nodeId - The ID of the node to enable inline editing for.  
   */  
  enableInlineEditing(nodeId) {  
    this._enableInlineEdit(nodeId);  
  }  
    /**  
   * Refreshes the tree view by rebuilding its structure.  
   */  
  refresh() {  
    this._refresh();  
  }  
  _dispatchEvent(eventName, detail) {  
    const event = new CustomEvent(eventName, { detail });  
    this.element.dispatchEvent(event);  
  }  
  // Event delegation for blur  
  _onBlur(e) {  
    const input = e.target.closest("input.xinput"); // Check if the event target is an input  
    if (!input) return;  
    const nodeId = this._normalizeId(input.dataset.id);  
    const node = this.findNode(nodeId);  
    if (!node) return;  
    const txt = this._getElementById(`${this.treeName}-${nodeId}-text`);  
    if (!txt) return;  
    const originalText = node.text;  
    if (input.value.trim() === "") {  
      this._toggleVisibility(input, false);  
      this._toggleVisibility(txt, true);  
      this._dispatchEvent("nodeEditCancelled", { node }); // Notify about cancellation  
      return;  
    }  
    if (input.value.trim() === originalText) {  
      this._toggleVisibility(input, false);  
      this._toggleVisibility(txt, true);  
      this._dispatchEvent("nodeEditCancelled", { node }); // Notify about cancellation  
      return;  
    }  
    // Update the node text  
    node.text = input.value.trim();  
    txt.textContent = input.value.trim();  
    input.value = input.value.trim();  
    this._toggleVisibility(input, false);  
    this._toggleVisibility(txt, true);  
    this._dispatchEvent("nodeEdited", { node });  
  }  
  // Event delegation for keydown  
  _onKeydown(e) {  
    const input = e.target.closest("input.xinput"); // Check if the event target is an input  
    if (!input) return;  
    const nodeId = this._normalizeId(input.dataset.id);  
    const node = this.findNode(nodeId);  
    if (!node) return;  
    const txt = this._getElementById(`${this.treeName}-${nodeId}-text`);  
    if (!txt) return;  
    const originalText = node.text;  
    if (e.key === "Enter") {  
      input.blur(); // Trigger blur event to save changes  
    } else if (e.key === "Escape") {  
      // Revert changes  
      node.text = originalText;  
      txt.textContent = originalText;  
      input.value = originalText;  
      input.blur(); // Trigger blur to hide the input  
    }  
  }  
  _enableInlineEdit(nodeId) {  
    const node = this.findNode(nodeId);  
    if (!node) return;  
    const txt = this._getElementById(`${this.treeName}-${nodeId}-text`);  
    const input = this._getElementById(`${this.treeName}-${nodeId}-input`);  
    if (!txt || !input) return;  
    // Set the input's value to the current text of the node  
    input.value = node.text;  
    // Toggle visibility for inline editing  
    this._toggleVisibility(txt, false);  
    this._toggleVisibility(input, true);  
    input.focus();  
  }  
}  
export default DaisyUITreeView;
```

  
  
And most of it was generated by AI and I just did some tweaks here and there to suit my final web component. I also told the thing to generate JSDoc related code for the component and injected it. I found out that in most cases, having descriptive names for your functions helps and it also studies your code to understand what it does.  
  
To test the functionality of the web component, I installed jest on my project.  
  
<https://jestjs.io/>  
  

```B4X
import { JSDOM } from 'jsdom';  
import DaisyUITreeView from '../src/DaisyUITreeView';  
import '@testing-library/jest-dom';  
  
describe('DaisyUITreeView', () => {  
  let container;  
  let treeView;  
  let node;  
  let dom;  
  let document;  
  beforeEach(() => {  
    dom = new JSDOM(`<!DOCTYPE html><html><head></head><body><div id="tree"></div></body></html>`);  
    global.document = dom.window.document;  
    global.window = dom.window;  
    document = dom.window.document;  
    container = document.getElementById('tree');  
    treeView = new DaisyUITreeView(container, {  
      hasCheckbox: true,  
      multipleSelect: false,  
      multipleCheck: false,  
      inlineEdit: false,  
    });  
    treeView.clear();  
    treeView.addNode('', 'a', '', 'Node A');  
    treeView.addNode('a', 'aa', '', 'Node AA');  
    treeView.addNode('', 'b', '', 'Node B');  
    treeView.refresh();  
    //console.log(dom.serialize());  
  });  
  afterEach(() => {  
    container = null;  
    treeView = null;  
    delete global.document;  
    delete global.window;  
  });  
   
  it('should initialize with default settings', () => {  
    expect(treeView.settings.hasCheckbox).toBe(true);  
    expect(treeView.settings.multipleSelect).toBe(true);  
  });  
  it('should add a new node', () => {     
    treeView.addNode('', 'c', '', 'Node C');  
    treeView.refresh();  
    node = treeView.findNode('c');  
    expect(node).not.toBeNull();  
    expect(node.text).toBe('Node C');  
  });  
  it('should remove a node', () => {  
    treeView.addNode('', 'c', '', 'Node C');  
    treeView.refresh();  
    treeView.removeNode('c')  
    expect(treeView.nodeExists('c')).toBe(false);  
  });  
  it('should expand and collapse a node', () => {  
    treeView.expandNode('a', true);  
    expect(treeView.findNode('a').expanded).toBe(true);  
    treeView.expandNode('a', false);  
    expect(treeView.findNode('a').expanded).toBe(false);  
  });  
  
  it('should select and deselect a node', () => {  
    treeView.selectNode('a', true);  
    expect(treeView.getSelectedNode().nodeId).toBe('a');  
    const nodeA = document.getElementById(`${treeView.treeName}-a`);  
    expect(nodeA.classList.contains('menu-active')).toBe(true);  
    treeView.selectNode('a', false);  
    node = treeView.getSelectedNode();  
    expect(node).toBeNull();  
  });  
  it('should check and uncheck nodes', () => {  
    treeView.checkNode('a', true);  
    expect(treeView.getCheckedNodes()).toContain('a');  
    expect(treeView.getCheckedNodes()).toContain('aa');  
    treeView.checkNode('a', false);  
    expect(treeView.getCheckedNodes()).not.toContain('a');  
    expect(treeView.getCheckedNodes()).not.toContain('aa');  
  });  
  it('should update node text', () => {  
    treeView.updateNode('a', '', 'Updated Node A', '');  
    expect(treeView.findNode('a').text).toBe('Updated Node A');  
  });  
  it('should enforce multiple select using selectNode', () => {  
    treeView.selectNode('a', true);  
    treeView.selectNode('b', true);  
    expect(treeView.getSelectedNodes().length).toBe(3);  
  });  
  it('should handle parent-child checkbox updates', () => {  
    treeView.addNode('', 'parent', '', 'Parent Node');  
    treeView.addNode('parent', 'child', '', 'Child Node');  
    treeView.refresh();  
    treeView.checkNode('parent', true);  
    expect(treeView.getCheckedNodes()).toContain('parent');  
    expect(treeView.getCheckedNodes()).toContain('child');  
  });  
  it('should expand all nodes', () => {  
    treeView.expandAll();  
    expect(treeView.tree.every(node => node.expanded)).toBe(true);  
  });  
  it('should collapse all nodes', () => {  
    treeView.expandAll();  
    treeView.collapseAll();  
    expect(treeView.tree.every(node => !node.expanded)).toBe(true);  
  });  
  it('should disable and enable a node', () => {  
    treeView.enableNode('a', false);  
    const node = treeView.findNode('a');  
    expect(node.disabled).toBe(true);  
    treeView.enableNode('a', true);  
    expect(node.disabled).toBe(false);  
  });  
  it('should select multiple nodes using selectNodes', () => {  
    treeView.selectNodes(['a', 'b']);  
    const selectedNodes = treeView.getSelectedNodes();  
    expect(selectedNodes).toEqual(['a', 'aa', 'b']);  
});  
it('should return an empty array if no nodes are selected', () => {  
    const selectedNodes = treeView.getSelectedNodes();  
    expect(selectedNodes).toEqual([]);  
});  
it('should update selected nodes when selectNodes is called again', () => {  
    treeView.addNode('', 'c', '', 'Node C');  
    treeView.refresh();  
    treeView.selectNodes(['a']);  
    treeView.selectNodes(['b', 'c']);  
    const selectedNodes = treeView.getSelectedNodes();  
    expect(selectedNodes).toEqual(['a', 'aa', 'b', 'c']);  
});  
  it('should clear all nodes', () => {  
    treeView.clear();  
    treeView.refresh();  
    expect(treeView.tree.length).toBe(0);  
    expect(treeView.getCheckedNodes().length).toBe(0);  
    expect(treeView.getSelectedNodes().length).toBe(0);  
  });  
  it('should hide a node and its children', () => {  
    treeView.hideNode('a');  
    const nodeA = document.getElementById(`${treeView.treeName}-a`);  
    const nodeAA = document.getElementById(`${treeView.treeName}-aa`);  
    expect(nodeA.classList.contains('hidden')).toBe(true);  
    expect(nodeAA.classList.contains('hidden')).toBe(true);  
     
    expect(treeView.findNode('a').visible).toBe(false);  
    expect(treeView.findNode('aa').visible).toBe(false);  
  });  
  it('should show a node and its children', () => {  
    treeView.hideNode('a'); // First hide the node  
    treeView.showNode('a'); // Then show it again  
    const nodeA = document.getElementById(`${treeView.treeName}-a`);  
    const nodeAA = document.getElementById(`${treeView.treeName}-aa`);  
    expect(nodeA.classList.contains('hidden')).toBe(false);  
    expect(nodeAA.classList.contains('hidden')).toBe(false);  
    expect(treeView.findNode('a').visible).toBe(true);  
    expect(treeView.findNode('aa').visible).toBe(true);  
  });  
  it('should not throw an error when hiding a non-existent node', () => {  
    expect(() => treeView.hideNode('nonexistent')).not.toThrow();  
  });  
  it('should not throw an error when showing a non-existent node', () => {  
    expect(() => treeView.showNode('nonexistent')).not.toThrow();  
  });  
});
```

  
  
The code for the unit test was also generated by copit, I just requested it to generate a unit test project of the component taking into consideration all use cases. Anyway, one can tell it do to anything, but still one needs to quality check the source code it generates a great deal. One mistake I made was to ask it to generate code and then I click replace. Some of the good code I had already done was deleted and I had to somehow revert back changes. So in most cases, I just copy the code I need to the target file myself.  
  
The nice thing is, even when you run into an error, you can ask it to explain what it means and find solutions for you.  
  
Sadly explaining how all of this works is beyond the scope of this tutorial. One needs to understand NodeJS and how to install packages etc. Mostly the copilot will give instructions on what to do and how.