$bibtex_use = 2;

# IEEEtran.cls and the IEEEtran*.bst styles live in dependencies/
ensure_path('TEXINPUTS', './dependencies//');
ensure_path('BSTINPUTS', './dependencies//');
