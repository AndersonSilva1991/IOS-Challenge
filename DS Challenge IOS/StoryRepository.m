#import "StoryRepository.h"
#import "Loja.h"

@implementation StoryRepository
-(NSMutableArray *) getAll{
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/mateuscp/DSChallengeiOS/main/jsonRequest.json"]];

    [urlRequest setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableArray *stores = [NSMutableArray new];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      if(httpResponse.statusCode == 200)
      {
          NSError *parseError = nil;
          NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
          NSLog(@"The response is - %@",responseDictionary);
          
          id Object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
          
          if([Object isKindOfClass:[NSDictionary class]] && error == nil)  {
              NSArray *arrayJson;
              
              if([[Object objectForKey:@"lojas"] isKindOfClass:[NSArray class] ]){
                  
                  arrayJson = [Object objectForKey:@"lojas"];
                
                  for (id storyJson in arrayJson) {
                      Loja * loja = [[Loja alloc] init];
                      loja.Id = [[storyJson objectForKey:@"id"] integerValue];
                      loja.nome = [storyJson objectForKey:@"nome"];
                      loja.telefone = [storyJson objectForKey:@"telefone"];
                      
                      loja.endereco = [[Endereco alloc] init];
                      id enderecoJson = [storyJson objectForKey:@"endereco"];
                      loja.endereco.complemento = [enderecoJson objectForKey:@"complemento"];
                      loja.endereco.bairro = [enderecoJson objectForKey:@"bairro"];
                      loja.endereco.numero = [[enderecoJson objectForKey:@"numero"] integerValue];
                      loja.endereco.logradouro = [enderecoJson objectForKey:@"logradouro"];
                      
                      [stores addObject:loja];
                  }
              }
              
          }
          
      }
      else
      {
        NSLog(@"Error");
      }
        
        dispatch_group_leave(group);
    }];
    
    [dataTask resume];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"Stores: %@", stores);
    return stores;
}
@end
