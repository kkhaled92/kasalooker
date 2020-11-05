view: blacklineexport {
  derived_table: {
    sql: select *
      from blackline_export.account_ex join blackline_export.location_entity
      on account_ex.entity_unique_identifier = location_entity.entity_unique_identifier
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: balance_sum_deficit {
    type: sum
    value_format: "#,##0.00"
    sql: ${balance_oct} - ${balance_sep} ;;
    drill_fields: [detail*]
  }

  measure: balance_sum {
    type: sum
    sql: ${balance}  ;;
    drill_fields: [detail*]
  }

  dimension: entity_unique_identifier {
    type: number
    sql: ${TABLE}.entity_unique_identifier ;;
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}.account_number ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: period_intake {
    type: date
    datatype: date
    sql: ${TABLE}.period_intake ;;
  }

  dimension: balance {
    type: number
    sql: ${TABLE}.balance ;;
  }

  dimension: balance_oct {
    type: number
    sql: CASE WHEN CAST(${period_intake} as date) = '2020-10-31' THEN
          ${TABLE}.balance
          ELSE 0
          END;;
  }

  dimension: balance_sep {
    type: number
    sql: CASE WHEN CAST(${period_intake} as date) = '2020-09-30' THEN
    ${TABLE}.balance
    ELSE 0
    END;;
  }

  dimension: entity_unique_identifier_1 {
    type: number
    sql: ${TABLE}.entity_unique_identifier_1 ;;
  }

  dimension: entity_name {
    type: string
    sql: ${TABLE}.entity_name ;;
  }

  set: detail {
    fields: [
      entity_unique_identifier,
      account_number,
      account_name,
      type,
      currency,
      period_intake,
      balance,
      entity_unique_identifier_1,
      entity_name
    ]
  }
}
