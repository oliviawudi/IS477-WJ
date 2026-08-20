RAW = "data/raw"
PROC = "data/processed"
FIG = "reports/figures"

rule all:
    input:
        expand(FIG + "/analysis_shed_{i}.png", i=range(1,10)),
        FIG + "/analysis_cfpb.png",
        FIG + "/analysis_merged_1.png",
        FIG + "/analysis_merged_2.png",
        PROC + "/merged.csv"

rule clean_shed:
    input:
        shed2024=RAW + "/shed2024.sas7bdat",
        shed2020=RAW + "/public2020.sas7bdat"
    output:
        shed20=PROC + "/shed20_cleaned.csv",
        shed24=PROC + "/shed24_cleaned.csv"
    shell:
        "python scripts/clean_shed.py --shed2024 {input.shed2024} --shed2020 {input.shed2020} --out20 {output.shed20} --out24 {output.shed24}"

rule clean_cfpb:
    input: RAW + "/volume_data_Score_Level_CRC.csv"
    output: PROC + "/cfpb_cleaned.csv"
    shell: "python scripts/clean_cfpb.py --infile {input} --out {output}"

rule match_sample_sizes:
    input:
        shed24=PROC + "/shed24_cleaned.csv",
        shed20=PROC + "/shed20_cleaned.csv"
    output: PROC + "/shed24_matched.csv"
    shell: "python scripts/shed24_match_shed20.py --shed24 {input.shed24} --shed20 {input.shed20} --out {output} --seed 2025"

rule aggregate_sheds:
    input:
        shed24=PROC + "/shed24_matched.csv",
        shed20=PROC + "/shed20_cleaned.csv"
    output: PROC + "/shed_combined.csv"
    shell: "python scripts/aggregate_sheds.py --shed24 {input.shed24} --shed20 {input.shed20} --out {output}"

rule shed_analysis:
    input: PROC + "/shed_combined.csv"
    output: expand(FIG + "/analysis_shed_{i}.png", i=range(1,10))
    shell: "python scripts/shed_analysis.py --shed {input} --outdir " + FIG

rule shed_credit:
    input:
        shed24=PROC + "/shed24_matched.csv",
        shed20=PROC + "/shed20_cleaned.csv"
    output:
        shed20=PROC + "/shed20_cardholders.csv",
        shed24=PROC + "/shed24_cardholders.csv"
    shell: "python scripts/shed_credit.py --shed24 {input.shed24} --shed20 {input.shed20} --out20 {output.shed20} --out24 {output.shed24}"

rule shed_credit_concat:
    input:
        shed24=PROC + "/shed24_cardholders.csv",
        shed20=PROC + "/shed20_cardholders.csv"
    output: PROC + "/shed_cardholders.csv"
    shell: "python scripts/shed_credit_concat.py --shed24 {input.shed24} --shed20 {input.shed20} --out {output}"

rule shed_group:
    input: PROC + "/shed_cardholders.csv"
    output: PROC + "/shed_by_year_proxy_group.csv"
    shell: "python scripts/shed_group.py --shed {input} --out {output}"

rule cfpb_group:
    input: PROC + "/cfpb_cleaned.csv"
    output: PROC + "/cfpb_by_year_group.csv"
    shell: "python scripts/cfpb_group.py --cfpb {input} --out {output}"

rule cfpb_analysis:
    input: PROC + "/cfpb_by_year_group.csv"
    output: FIG + "/analysis_cfpb.png"
    shell: "python scripts/cfpb_analysis.py --cfpb {input} --out {output}"

rule merge:
    input:
        cfpb=PROC + "/cfpb_by_year_group.csv",
        shed=PROC + "/shed_by_year_proxy_group.csv"
    output: PROC + "/merged.csv"
    shell: "python scripts/merge.py --cfpb {input.cfpb} --shed {input.shed} --out {output}"

rule merge_analysis:
    input: PROC + "/merged.csv"
    output:
        out1=FIG + "/analysis_merged_1.png",
        out2=FIG + "/analysis_merged_2.png"
    shell: "python scripts/merge_analysis.py --merged {input} --out1 {output.out1} --out2 {output.out2}"
