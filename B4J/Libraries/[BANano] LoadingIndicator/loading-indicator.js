// LOADING AUTOMATICO con BANano.Await
// Per esecuzione manuale: 
//' Mostra
//BANano.RunJavascriptMethod("LoadingIndicator", Array(True, "Salvataggio in corso..."))
//' ... operazione asincrona con BANano.Await ...
//' Nascondi
//BANano.RunJavascriptMethod("LoadingIndicator", Array(False, ""))
//
// ============================================
// LOADING INDICATOR - versione tutto-in-uno
// ============================================

(function () {
    'use strict';

    // --- 1. Inietta il CSS ---
    const style = document.createElement('style');
    style.textContent = `
        .loading-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.45);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            backdrop-filter: blur(2px);
        }
        .loading-overlay.visible {
            display: flex;
        }
        .loading-box {
            background: #ffffff;
            padding: 25px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            font-family: Arial, sans-serif;
            min-width: 180px;
        }
        .loading-spinner {
            width: 45px;
            height: 45px;
            border: 5px solid #e0e0e0;
            border-top: 5px solid #3498db;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        .loading-text {
            color: #333;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
        }
        @keyframes spin {
            0%   { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    `;
    document.head.appendChild(style);

    // --- 2. Crea l'HTML via DOM ---
    const overlay = document.createElement('div');
    overlay.id = 'loadingIndicator';
    overlay.className = 'loading-overlay';

    const box = document.createElement('div');
    box.className = 'loading-box';

    const spinner = document.createElement('div');
    spinner.className = 'loading-spinner';

    const text = document.createElement('div');
    text.className = 'loading-text';
    text.id = 'loadingText';
    text.textContent = 'Attendere prego...';

    box.appendChild(spinner);
    box.appendChild(text);
    overlay.appendChild(box);

    // Aggiunge l'overlay al body quando il DOM è pronto
    if (document.body) {
        document.body.appendChild(overlay);
    } else {
        document.addEventListener('DOMContentLoaded', function () {
            document.body.appendChild(overlay);
        });
    }

    // --- 3. Contatore per chiamate multiple ---
    let _loadingCounter = 0;

    // --- 4. Funzione principale ---
    window.LoadingIndicator = function (show, msg) {
        const el = document.getElementById('loadingIndicator');
        const txt = document.getElementById('loadingText');
        if (!el) return;

        if (show) {
            _loadingCounter++;
            if (msg) txt.textContent = msg;
            el.classList.add('visible');
        } else {
            _loadingCounter = Math.max(0, _loadingCounter - 1);
            if (_loadingCounter === 0) {
                el.classList.remove('visible');
            }
        }
    };

    // --- 5. Intercettazione automatica di fetch ---
    const _originalFetch = window.fetch;
    window.fetch = function () {
        window.LoadingIndicator(true, 'Caricamento dati...');
        return _originalFetch.apply(this, arguments)
            .finally(function () {
                window.LoadingIndicator(false);
            });
    };

})();