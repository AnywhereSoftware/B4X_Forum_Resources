#import "iCore.h"

#import <Foundation/Foundation.h>

//~version: 1.00
//~shortname: SimplePing
//~Event: Start (Success As Boolean)
//~Event: PacketSent (SequenceNumber As Int, Success As Boolean)
//~Event: PacketReceived (SequenceNumber As Int)
@interface iPing : NSObject
/**
 * Initializes the object and sets the taget host.
 */
-(void)Initialize:(B4I *)bi :(NSString *)EventName :(NSString*)HostName;

/**
 * Prepares the socket. The Start event will be raised.
 */
- (void)Start;
/**
 *Releases the resources.
 */
- (void)Stop;
/**
 * Sends a ping request. The PacketSent event will be raised.
 */
- (void)Send;
@end
