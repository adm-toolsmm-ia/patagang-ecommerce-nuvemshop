/**
 * PATAGANG - Version Info & Deployment Status Console
 * Displays deployment version and recent changes in browser console
 */

(function() {
  const versionInfo = {
    app_name: "PATAGANG Nuvemshop",
    version: "1.1.1",
    environment: "production",
    deployment_date: "2026-03-20T03:46:27Z",
    git_commit: "9502c44",
    git_branch: "main",
    console_message: "🚀 PATAGANG v1.1.1 (2026-03-20) - PDP Layout Fix deployed - Commit: 9502c44"
  };

  // Estilos para console
  const styles = {
    header: "color: #EAFE67; font-weight: bold; font-size: 14px; background: #000; padding: 8px; border-radius: 4px;",
    info: "color: #fff; font-size: 12px; background: #333; padding: 4px;",
    success: "color: #2d3a00; font-weight: bold; font-size: 12px;",
    timestamp: "color: #888; font-size: 11px;"
  };

  // Log principal no console
  console.log("%c" + versionInfo.console_message, styles.header);

  // Informações detalhadas
  console.group("%cℹ️ Deployment Details", styles.info);
  console.log("%cApp: " + versionInfo.app_name, styles.info);
  console.log("%cVersion: " + versionInfo.version, styles.info);
  console.log("%cEnvironment: " + versionInfo.environment, styles.info);
  console.log("%cGit Commit: " + versionInfo.git_commit, styles.info);
  console.log("%cGit Branch: " + versionInfo.git_branch, styles.info);
  console.log("%cDeployed: " + versionInfo.deployment_date, styles.timestamp);
  console.log("%c✓ PDP Layout Fix: Empty space on right side of product card eliminated", styles.success);
  console.log("%c✓ Column proportions optimized: 57% (image) + 43% (info) = 100%", styles.success);
  console.groupEnd();

  // Disponibilizar no window para debug
  window.__PATAGANG_VERSION__ = versionInfo;

  // Log adicional para identificação
  console.log("%cAccess version info: window.__PATAGANG_VERSION__", styles.info);
})();
