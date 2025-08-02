
with poverty as (
    select
           district_name,
           {{ null_to_zero('amount_of_2tutors_2kids_1x5yold') }} as amount_1tutor,
           {{ null_to_zero('amount_of_1tutor_1kid_1x5yold') }} as amount_2tutor,
           {{ null_to_zero('amount_of_single') }} as amount_single,
           {{ null_to_zero('amount_of_below_poverty_line_20753_mbm') }} as abp_20753,
           {{ null_to_zero('amount_of_below_poverty_line_29349_mbm') }} as abp_29349,
           {{ null_to_zero('amount_of_below_poverty_line_41506_mbm') }} as abp_41506,
           {{ null_to_zero('amount_of_below_standard_line_39099_mbm') }} as abs_39099,
           {{ null_to_zero('amount_of_below_standard_line_61009_mbm') }} as abs_61009
    from "dev"."public"."poverty_montreal_stage"
),

municipality as (
    select
        DISTINCT district_id,
        {{ clean_string('district_name') }} as cleaned_d_name
    from "dev"."public"."municipality_montreal_stage"
)

select
    m.district_id,
    p.district_name,
    p.amount_1tutor,
    p.amount_2tutor,
    p.amount_single,
    p.abp_20753,
    p.abp_29349,
    p.abp_41506,
    p.abs_39099,
    p.abs_61009
from poverty p
left join municipality m
    on lower(trim(substring(p.district_name, position('_' in p.district_name) + 1))) = lower(trim(m.cleaned_d_name))
