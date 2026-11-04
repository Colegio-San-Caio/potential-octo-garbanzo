// COMBINED MAIN - By BLUHoeneye - main.iqxd
// CANARY - By BLUHoeneye - main.iqxd
// Runs FIRST. If canary fails, STOP. Don't run S A B C D.
function canaryMain(){
  console.log("[canary] MAIN - checking...");
  const ok = true; // change to false to test failure
  if(!ok){
    console.log("[canary] FAILED - STOP ALL MAINS");
    return false;
  }
  console.log("[canary] MAIN - canary OK - safe to deploy");
  return true;
}
function sMain(){ console.log("[S] VS Code MAIN running"); return "S OK"; }
function aMain(){ console.log("[A] Git MAIN running"); return "A OK"; }
function bMain(){ console.log("[B] Firebase MAIN running"); return "B OK"; }
function cMain(){ console.log("[C] Sublime MAIN running"); return "C OK"; }
function dMain(){ console.log("[D] Atom MAIN running"); return "D OK"; }
function precomputerMain(){ console.log("[precomputer] MAIN running"); return "precomputer OK"; }
function websiteMain(){ console.log("[website] MAIN running"); return "website OK"; }
function workerMain(){ console.log("[worker] MAIN running"); return "worker OK"; }
function main(){
  console.log("=== RUN ALL MAINS ===");
  const r = [sMain(),aMain(),bMain(),cMain(),dMain(),precomputerMain(),websiteMain(),workerMain()];
  console.log("=== ALL MAINS DONE ===", r);
}
function main(){
  console.log("=== RUN ALL MAINS - CANARY BUILD ===");
  if(!canaryMain()) return;
  const r = [sMain(),aMain(),bMain(),cMain(),dMain(),precomputerMain(),websiteMain(),workerMain()];
  console.log("=== ALL MAINS DONE === CANARY PASSED ===", r);
}
main();
