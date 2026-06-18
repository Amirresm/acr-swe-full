cat <<'EOF'
Setup: 
1. cd auto-code-rover && conda env create -f environment.yml && cd ..
2. source conf/example-conf.sh (EDIT THIS FILE TO CHANGE CONFIGURATIONS)

Setup testbed:
1. cd SWE-Bench && ./setup-testbed.sh && cd ..

Run ACR Generation:
1. cd auto-code-rover && ./run-acr.sh && cd ..

Run ACR Evaluation:
1. cd auto-code-rover && ./run-eval.sh && cd ..

EOF
