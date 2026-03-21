/**
 * PATAGANG - Version Info
 * Source: theme-deploy-corrigido/VERSION.json
 * Purpose: Display deployment version in browser console
 * Updated: Automatically before each FTP deploy
 */

(function() {
  // Single source of truth - matches VERSION.json
  const VERSION = "1.1.4";
  const DEPLOY_DATE = "2026-03-21";

  // Console output - styled for visibility
  console.log("%c📦 PATAGANG v" + VERSION + " (" + DEPLOY_DATE + ")",
    "color: #EAFE67; font-weight: bold; font-size: 14px; background: #000; padding: 8px; border-radius: 4px; margin: 8px 0;");

  // Make version globally accessible for debugging
  window.__PATAGANG_VERSION__ = {
    version: VERSION,
    date: DEPLOY_DATE,
    timestamp: new Date().toISOString()
  };

  // Log version object for developers
  console.log("ℹ️ Version Info:", window.__PATAGANG_VERSION__);
})();
