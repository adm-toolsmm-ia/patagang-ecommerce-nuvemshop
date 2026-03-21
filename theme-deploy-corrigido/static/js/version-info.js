/**
 * PATAGANG - Version Info
 * Source: theme-deploy-corrigido/VERSION.json
 * Purpose: Display deployment version in browser console
 * Updated: Automatically before each FTP deploy
 * Git Commit: PENDING_NEW_COMMIT
 * Tag: v1.1.7-pdp-final-adjustments
 */

(function() {
  // Single source of truth - matches VERSION.json
  const VERSION = "1.1.8";
  const DEPLOY_DATE = "2026-03-21";
  const GIT_COMMIT = "PENDING_NEW_COMMIT";
  const GIT_TAG = "v1.1.8-pdp-layout-complete-fix";

  // Console output - styled for visibility
  console.log("%c📦 PATAGANG v" + VERSION + " (" + DEPLOY_DATE + ") — PDP Layout Complete Fix ✅",
    "color: #EAFE67; font-weight: bold; font-size: 14px; background: #000; padding: 8px; border-radius: 4px; margin: 8px 0;");

  // Make version globally accessible for debugging
  window.__PATAGANG_VERSION__ = {
    version: VERSION,
    date: DEPLOY_DATE,
    git_commit: GIT_COMMIT,
    git_tag: GIT_TAG,
    timestamp: new Date().toISOString(),
    environment: "production"
  };

  // Log version object for developers
  console.log("ℹ️ Version Info:", window.__PATAGANG_VERSION__);
  console.log("🔗 Git Commit: " + GIT_COMMIT);
  console.log("🏷️  Git Tag: " + GIT_TAG);
})();
