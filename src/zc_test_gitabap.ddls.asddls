@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.sapObjectNodeType.name: 'ZTEST_GITABAP'
define root view entity ZC_TEST_GITABAP
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_TEST_GITABAP
{
  key Ssnid,
  CreatedBy,
  CreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
